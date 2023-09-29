//
//  TranslationTabView.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/16/23.
//

import SwiftUI

struct TranslationTabView: View {
    let currencyCode: String
    let languageCode: String
    let countryInformation: [Country]
    
    var body: some View {
        TabView {
            self.translationScanner
            self.currencyConverter
        }
        .accentColor(.white)
    }
}

extension TranslationTabView {
    var translationScanner: some View {
        TextScannerView(languageCode: self.languageCode, countryInformation: self.countryInformation)
            .tabItem {
                Image(systemName: "camera")
            }
            .toolbarBackground(Color.black, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
    
    var currencyConverter: some View {
        CurrencyConverterView(currencyCode: self.currencyCode)
            .tabItem {
                Image(systemName: "dollarsign")
            }
            .toolbarBackground(Color.black, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
}
