//
//  FlagChoicesVM.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/23/23.
//

import Foundation

@MainActor final class FlagChoicesVM: ObservableObject {
    @Published private(set) var alertMessage = ""
    @Published private(set) var isSelected = false
    @Published private(set) var languageCode = ""
    @Published private(set) var currencyCode = ""
    @Published var canNavigate = false
    @Published var triggerAlert = false
    
    func updateLanguage(from country: Country) {
        if country.languageCode == self.languageCode {
            self.languageCode = ""
            self.currencyCode = ""
        } else {
            self.languageCode = country.languageCode
            self.currencyCode = country.currencyCode
        }
        self.isSelected.toggle()
    }
    
    func checkNavigationStatus() {
        if self.isSelected {
            self.canNavigate = true
        } else {
            self.alertMessage = "Please chose a language"
            self.toggleAlert()
        }
    }
    
    func toggleAlert() {
        self.triggerAlert.toggle()
    }
    
    func toggleUserChoice() {
        self.isSelected.toggle()
    }
}

