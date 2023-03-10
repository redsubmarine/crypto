//
//  CryptoNickApp.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI

@main
struct CryptoNickApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
