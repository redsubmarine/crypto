//
//  CryptoNickApp.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI

@main
struct CryptoNickApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
