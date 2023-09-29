//
//  ExchangeRate.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/16/23.
//

import Foundation

struct ExchangeRate: Codable {
    let rates: [String: Double]
}

extension ExchangeRate {
    var updatedDictionaryValues: [String: Any] {
        var updatedDictionary = [String: Any]()
        for (key, value) in rates {
            let flag: String
            let symbol: String
            let placement: Placement
            
            switch key {
            case "JPY":
                symbol = "¥"
                placement = .before
                flag = "🇯🇵"
            case "USD":
                symbol = "$"
                placement = .before
                flag = "🇺🇸"
            case "EUR":
                symbol = "€"
                placement = .after
                flag = "🇩🇪"
            case "PLN":
                symbol = "zł"
                placement = .before
                flag = "🇵🇱"
            case "RUB":
                symbol = "₽"
                placement = .after
                flag = "🇷🇺"
            case "TRY":
                symbol = "₺"
                placement = .after
                flag = "🇹🇷"
            case "DKK":
                symbol = "kr"
                placement = .before
                flag = "🇩🇰"
            case "ESP":
                symbol = "Pt"
                placement = .after
                flag = "🇪🇸"
            case "NOK":
                symbol = "kr"
                placement = .before
                flag = "🇳🇴"
            case "CHF":
                symbol = "₣"
                placement = .before
                flag = "🇨🇭"
            case "SEK":
                symbol = "kr"
                placement = .before
                flag = "🇸🇪"
            case "GBP":
                symbol = "£"
                placement = .before
                flag = "🇬🇧"
            default:
                symbol = "?"
                placement = .before
                flag = ""
            }
            updatedDictionary[key] = ["flag": flag, "amount": value, "placement": placement, "symbol": symbol] as [String : Any]
        }
        return updatedDictionary
    }
}

enum Placement {
    case before
    case after
}

struct CurrencyInfo: Hashable {
    let currencyKey: String
    let flag: String
    let amount: Double
    let placement: Placement
    let symbol: String 
}
