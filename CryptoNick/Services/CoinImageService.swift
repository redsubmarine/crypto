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
    private let coin: Coin
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let cachedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = cachedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        imageSubscription = NetworkingManager.download(url: coin.image)
            .tryMap({ UIImage(data: $0) })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                guard let self, let image else { return }
                self.image = image
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: image, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
