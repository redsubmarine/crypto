//
//  CoinImageViewModel.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    
    private let dataService: CoinImageService
    var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.dataService = .init(coin: coin)
        self.isLoading = true
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$image
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self]  _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
            
            
    }
}
