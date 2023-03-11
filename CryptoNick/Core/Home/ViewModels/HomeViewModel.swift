//
//  HomeViewModel.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [Statistic] = []
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var marketData: MarketData?
    
    @Published var isLoading = false
    @Published var searchText = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubsribers()
    }
    
    func addSubsribers() {
        $searchText.map({ $0.lowercased() })
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] coins in
                self?.portfolioCoins = coins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink(receiveValue: { [weak self] statistics in
                self?.statistics = statistics
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        
        HapticManager.notification(type: .success)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        coins.filter({
            $0.name.lowercased().contains(text) ||
            $0.symbol.lowercased().contains(text) ||
            $0.id.lowercased().contains(text) ||
            text.isEmpty
        })
    }
    
    private func mapAllCoinsToPortfolioCoins(coins: [Coin], portfolios: [Portfolio]) -> [Coin] {
        coins.compactMap({ coin -> Coin? in
            guard let entity = portfolios.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        })
    }
    
    private func mapGlobalMarketData(data: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        guard let data else { return [] }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24 Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map(\.currentHoldingsValue)
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map({ coin -> Double in
                let current = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                
                let previousValue = current / (1 + percentChange)
                return previousValue
            })
            .reduce(0, +)
            
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = Statistic(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange
        )
        return [
            marketCap,
            volume,
            btcDominance,
            portfolio,
        ]
    }
}
