//
//  HomeViewModel.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    @Published var searchText = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubsribers()
    }
    
    func addSubsribers() {
        $searchText.map({ $0.lowercased() })
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        coins.filter({
            $0.name.lowercased().contains(text) ||
            $0.symbol.lowercased().contains(text) ||
            $0.id.lowercased().contains(text) ||
            text.isEmpty
        })
    }
}
