//
//  CurrencyConverterView.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/16/23.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var currencyConverterVM = CurrencyConverterVM()
    @State private(set) var inputAmount = ""
    @State private(set) var currencyCode: String
    var currencyCodesArray = ["JPY", "USD", "EUR", "PLN", "RUB", "TRY", "DKK", "ESP", "NOK", "SEK", "GBP"]
    
    var body: some View {
        ZStack {
            VStack {
                self.header
                self.currencyList
            }
            .padding()
            .font(.oswald(size: 20))
        }
        .task {
            await currencyConverterVM.getConversions(forCurrency: self.currencyCode)
        }
        .onChange(of: self.currencyCode) { newValue in
            Task {
                await currencyConverterVM.getConversions(forCurrency: self.currencyCode)
            }
        }
        .alert(isPresented: $currencyConverterVM.triggerAlert, content: {
            Alert(title: Text("Alert"), message: Text(currencyConverterVM.alertMessage), dismissButton: .default(Text("OK")) {
                currencyConverterVM.toggleAlert()
            })
        })
    }
}

extension CurrencyConverterView {
    var header: some View {
        HStack {
            self.currencyMenu
            self.searchBarAndButton
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
    }
    
    var searchBarAndButton: some View {
        HStack {
            TextField("Enter amount here", text: self.$inputAmount)
                .keyboardType(.decimalPad)
                .padding(.leading)
            
            Button {
                self.handleButtonTap()
            } label: {
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(.black)
                    .font(.system(size: 25))
            }
        }
    }
    
    var currencyMenu: some View {
        Menu {
            Picker(selection: self.$currencyCode) {
                ForEach(self.currencyCodesArray, id: \.self) { code in
                    Text(code)
                }
            } label: {}
        } label: {
            Text("\(currencyConverterVM.getFlag(for: self.currencyCode))")
                .font(.system(size: 28))
            Text("\(self.currencyCode)")
                .foregroundColor(.black)
        }
    }
    
    var currencyList: some View {
        List {
            ForEach(currencyConverterVM.currencyInfo, id: \.self) { currencyInfo in
                HStack {
                    Text(currencyInfo.currencyKey)
                    Text(currencyInfo.flag)
                        .font(.system(size: 28))
                    Spacer()
                    switch currencyInfo.placement {
                    case .before:
                        Text("\(currencyInfo.symbol)\(currencyInfo.amount.twoDecimalRound())")
                    case .after:
                        Text("\(currencyInfo.amount.twoDecimalRound())\(currencyInfo.symbol)")
                    }
                }
                .padding(.vertical, 8)
            }

        }
        .listStyle(PlainListStyle())
        .scrollIndicators(.never)
    }
}

extension CurrencyConverterView {
    func handleButtonTap() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        currencyConverterVM.updateConversionAmounts(from: Double(self.inputAmount) ?? 0.0)
        self.inputAmount = ""
    }
}

