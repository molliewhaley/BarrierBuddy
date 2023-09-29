//
//  CurrencyClient.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/15/23.
//

import Foundation

final class CurrencyClient {
    static let shared = CurrencyClient()
    
    func getConversions(from currency: String, to currencies: String) async throws -> ExchangeRate {
        let urlString =  "https://api.exchangerate.host/latest?base=\(currency)&symbols=\(currencies)"
        
        guard let url = URL(string: urlString) else {
            throw ApiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ExchangeRate.self, from: data)
            return decodedData
            
        } catch {
            throw ApiError.invalidData
        }
    }
}

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
