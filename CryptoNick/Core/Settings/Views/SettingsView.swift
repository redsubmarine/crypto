//
//  SettingsView.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/12.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    let defaultURL = URL(string: "https://apple.com")!
    let youtubeURL = URL(string: "https://youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://coingecko.com")!
    let personalURL = URL(string: "https://redsubmarine.github.io")!

    var body: some View {
        NavigationView {
            List {
                swiftfulthinkingSection
                coinGeckoSection
                developerSection
                appplicationSection
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var swiftfulthinkingSection: some View {
        Section(content: {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftfulThinking course on Youtube. It uses MVVM Architecture, Combine, and CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on Youtube", destination: youtubeURL)
            Link("Support his coffee addiction", destination: coffeeURL)
        }, header: {
            Text("Swiftful Thinking")
        })
    }
    
    private var coinGeckoSection: some View {
        Section(content: {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coingeckoURL)
        }, header: {
            Text("Coingecko")
        })
    }
    
    private var developerSection: some View {
        Section(content: {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by red. It uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, publishers/subcribers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Visit Website", destination: personalURL)
        }, header: {
            Text("Developer")
        })
    }
    
    private var appplicationSection: some View {
        Section(content: {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        }, header: {
            Text("Appplication")
        })
    }
}
