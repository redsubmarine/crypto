//
//  DetailViewModel.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/12.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailService = .init(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { [weak self] coinDetails in
                print("RECIEVED COIN DETAIL DATA")
                print(coinDetails)
            }
            .store(in: &cancellables)
    }
}
