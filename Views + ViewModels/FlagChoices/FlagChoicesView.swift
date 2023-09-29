//
//  FlagChoicesView.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/13/23.
//

import SwiftUI
import VisionKit

struct FlagChoicesView: View {
    @StateObject private var flagChoicesVM = FlagChoicesVM()
    private let countryInformation: [Country] = [Country(id: UUID(), language: "Danish", image: "Denmark", languageCode: "da", currencyCode: "DKK"), Country(id: UUID(), language: "Italian", image: "Italy", languageCode: "it", currencyCode: "EUR"), Country(id: UUID(), language: "German", image: "Germany", languageCode: "de", currencyCode: "EUR"), Country(id: UUID(), language: "Greek", image: "Greece", languageCode: "el", currencyCode: "EUR"), Country(id: UUID(), language: "Russian", image: "Russia", languageCode: "ru", currencyCode: "RUB"), Country(id: UUID(), language: "Japanese", image: "Japan", languageCode: "ja", currencyCode: "JPY"), Country(id: UUID(), language: "Turkish", image: "Turkey", languageCode: "tr", currencyCode: "TRY"), Country(id: UUID(), language: "Polish", image: "Poland", languageCode: "pl", currencyCode: "PLN"), Country(id: UUID(), language: "Finnish", image: "Finland", languageCode: "fi", currencyCode: "EUR"), Country(id: UUID(), language: "French", image: "France", languageCode: "fr", currencyCode: "EUR"), Country(id: UUID(), language: "Spanish", image: "Spain", languageCode: "es", currencyCode: "ESP"), Country(id: UUID(), language: "English", image: "America", languageCode: "en", currencyCode: "USD")]
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                self.fullFlagView
                self.navigationButton
            }
        }
        .alert(isPresented: $flagChoicesVM.triggerAlert) {
            Alert(
                title: Text("Error"),
                message: Text(flagChoicesVM.alertMessage),
                dismissButton: .default(Text("OK")) {
                    flagChoicesVM.toggleAlert()
                })
        }
        .fullScreenCover(isPresented: $flagChoicesVM.canNavigate) {
            TranslationTabView(currencyCode: flagChoicesVM.currencyCode, languageCode: flagChoicesVM.languageCode, countryInformation: self.countryInformation)
        }
    }
}

extension FlagChoicesView {
    var fullFlagView: some View {
        HStack(spacing: 20) {
            FlagRowView(flagChoicesVM: self.flagChoicesVM, startIndex: 0, capIndex: 4, countryInformation: self.countryInformation)
            FlagRowView(flagChoicesVM: self.flagChoicesVM, startIndex: 4, capIndex: 8, countryInformation: self.countryInformation)
            FlagRowView(flagChoicesVM: self.flagChoicesVM, startIndex: 8, capIndex: 12, countryInformation: self.countryInformation)
        }
    }
    
    var navigationButton: some View {
        Button {
            flagChoicesVM.checkNavigationStatus()
        } label: {
            Image(systemName: "arrow.right")
                .font(.oswald(size: 28))
                .foregroundColor(.white)
                .padding(15)
        }
        .background(Color.black)
        .cornerRadius(10)
    }
}

struct FlagRowView: View {
    @ObservedObject var flagChoicesVM: FlagChoicesVM
    let startIndex: Int
    let capIndex: Int
    let countryInformation: [Country]
    
    var body: some View {
        VStack {
            ForEach(startIndex..<capIndex, id: \.self) { index in
                VStack(spacing: 12) {
                    FlagImage(flagChoicesVM: flagChoicesVM, index: index, countryInformation: countryInformation)
                        .onTapGesture {
                            flagChoicesVM.updateLanguage(from: countryInformation[index])
                        }
                    Text(countryInformation[index].language)
                        .font(.oswald(size: 20))
                }
                .padding(5)
            }
        }
    }
}

struct FlagImage: View {
    @ObservedObject var flagChoicesVM: FlagChoicesVM
    let index: Int
    let countryInformation: [Country]
    
    var body: some View {
        Image(countryInformation[index].image)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(Color.black, lineWidth: flagChoicesVM.languageCode == countryInformation[index].languageCode ? 5 : 3)
            }
    }
}

