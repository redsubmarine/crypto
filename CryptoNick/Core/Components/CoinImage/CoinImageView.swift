//
//  CoinImageView.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject private var viewModel: CoinImageViewModel
    
    init(coin: Coin) {
        _viewModel = .init(wrappedValue: .init(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
