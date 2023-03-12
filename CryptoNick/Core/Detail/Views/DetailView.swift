//
//  DetailView.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/12.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        ZStack {
            Text(coin.name)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
