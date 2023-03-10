//
//  CoinImageService.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage?
    var imageSubscription: AnyCancellable?
    
    init(coin: Coin) {
        getCoinImage(coin: coin)
    }
    
    private func getCoinImage(coin: Coin) {
        imageSubscription = NetworkingManager.download(url: coin.image)
            .tryMap({ UIImage(data: $0) })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
    }
}
