//
//  TextScannerView.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/11/23.
//

import SwiftUI
import VisionKit
import LibreTranslate

struct TextScannerView: View {
    @StateObject private var textScannerVM = TextScannerVM() // changed
    @Environment(\.dismiss) private var dismiss
    @State private(set) var languageCode: String
    let countryInformation: [Country]
    
    var body: some View {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    self.languageScannerMenu
                    DataScanner(textScannerVM: self.textScannerVM, languageCode: self.$languageCode)
                    Text(textScannerVM.translatedText ?? "")
                        .boxForTranslation()
                }
            }
            .onAppear {
                textScannerVM.triggerScanner()
            }
            .onDisappear {
                textScannerVM.clearText()
            }
            .alert(isPresented: $textScannerVM.triggerAlert, content: {
                Alert(title: Text("Alert"), message: Text(textScannerVM.errorMessage), dismissButton: .default(Text("OK")) {
                    textScannerVM.toggleError()
                })
            })
        }
}

extension TextScannerView {
    var languageScannerMenu: some View {
        HStack {
            Spacer()
            Menu {
                ForEach(countryInformation, id: \.id) { country in
                    Button {
                        self.languageCode = country.languageCode
                    } label: {
                        Text(country.language)
                    }
                }
            } label: {
                Label("", systemImage: "globe")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .padding(5)
            }
        }
    }
}
