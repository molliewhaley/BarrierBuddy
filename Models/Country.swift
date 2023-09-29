//
//  Country.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/14/23.
//

import Foundation

struct Country: Identifiable {
    let id: UUID
    let language: String
    let image: String
    let languageCode: String
    let currencyCode: String
}
