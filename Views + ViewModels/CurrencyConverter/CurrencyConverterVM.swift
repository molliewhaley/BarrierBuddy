//
//  CurrencyConverterVM.swift
//
//  BarrierBuddyApp
//  Created by Mollie Whaley on 9/17/23.
//
import Foundation

@MainActor final class CurrencyConverterVM: ObservableObject {
    @Published private(set) var exchangeRateData: ExchangeRate = ExchangeRate(rates: [:])
    @Published private(set) var convertedRateDictionary: [String: Any] = [:]
    @Published private(set) var alertMessage = ""
    @Published var triggerAlert = false
    private var countriesAndRatesReference: [String: Double] = [:]
    
    var currencyInfo: [CurrencyInfo] {
        var info: [CurrencyInfo] = []
        
        for (currencyKey, value) in convertedRateDictionary {
            if let currencyValue = value as? [String: Any],
               let amount = currencyValue["amount"] as? Double,
               let flag = currencyValue["flag"] as? String,
               let symbol = currencyValue["symbol"] as? String,
               let placement = currencyValue["placement"] as? Placement {
                let currencyInfo = CurrencyInfo(currencyKey: currencyKey, flag: flag, amount: amount, placement: placement, symbol: symbol)
                info.append(currencyInfo)
            }
        }
        
        return info
    }
    
    
    func getConversions(forCurrency currency: String) async {
        if currency != "" {
            do {
                let currencyString = adjustArrayForApi(excluding: currency)
                if let currencyString = currencyString {
                    let data = try await CurrencyClient.shared.getConversions(from: currency, to: currencyString)
                    self.convertedRateDictionary = data.updatedDictionaryValues
                    self.countriesAndRatesReference = data.rates
                }
            } catch ApiError.invalidURL {
                self.toggleAlert()
                self.alertMessage = "Unresolved issue. We're working on fixing it."
            } catch ApiError.invalidResponse {
                self.toggleAlert()
                self.alertMessage = "Server error. Try again later."
            } catch ApiError.invalidData {
                self.toggleAlert()
                self.alertMessage = "Problem finding recipes. Try again."
            } catch {
                self.toggleAlert()
                self.alertMessage = "Unexpected problem. Try again."
            }
        } else {
            self.toggleAlert()
            self.alertMessage = "Enter a number."
        }
    }
    
    
    func adjustArrayForApi(excluding currency: String) -> String? {
        var currencyCodesArray = ["JPY", "USD", "EUR", "PLN", "RUB", "TRY", "DKK", "ESP", "NOK", "SEK", "GBP"]
        if let index = currencyCodesArray.firstIndex(of: currency) {
            currencyCodesArray.remove(at: index)
            var currencyString = currencyCodesArray.joined(separator: " ")
            currencyString = currencyString.replacingOccurrences(of: " ", with: ",")
            return currencyString
        } else {
            return nil
        }
    }
    
    func toggleAlert() {
        self.triggerAlert.toggle()
    }
    
    func getFlag(for currency: String) -> String {
        switch currency {
        case "JPY":
            return "🇯🇵"
        case "USD":
            return "🇺🇸"
        case "EUR":
            return "🇩🇪"
        case "PLN":
            return "🇵🇱"
        case "RUB":
            return "🇷🇺"
        case "TRY":
            return "🇹🇷"
        case "DKK":
            return "🇩🇰"
        case "ESP":
            return "🇪🇸"
        case "NOK":
            return "🇳🇴"
        case "CHF":
            return "🇨🇭"
        case "SEK":
            return "🇸🇪"
        case "GBP":
            return "🇬🇧"
        default:
            return ""
        }
    }
    
    func updateConversionAmounts(from number: Double) {
        if number != 0.0 {
            for (key, value) in convertedRateDictionary {
                if var valueDict = value as? [String: Any], let numericValue = valueDict["amount"] as? Double {
                    let newValue = numericValue * number
                    valueDict["amount"] = newValue
                    convertedRateDictionary[key] = valueDict as Any
                }
            }
        } else {
            self.toggleAlert()
            self.alertMessage = "Number needs to be greater than 0."
        }
    }
} 


