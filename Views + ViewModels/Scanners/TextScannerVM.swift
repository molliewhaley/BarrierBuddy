//
//  TextScannerVM.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/12/23.
//

import LibreTranslate
import VisionKit
import SwiftUI

@MainActor final class TextScannerVM: ObservableObject {
    @Published private(set) var translatedText: String?
    @Published private(set) var errorMessage = ""
    @Published private(set) var startScanning = false
    @Published var triggerAlert = false
    
    func translateText(using message: String, to language: String) async {
        let translator = Translator("https://libretranslate.de")
        do {
            let translation = try await translator.translate(
                message,
                from: "auto",
                to: language)
            self.translatedText = translation
        } catch {
            self.triggerAlert = true
            self.errorMessage = "Error translating."
        }
    }
    
    func toggleError() {
        self.triggerAlert.toggle()
    }
    
    func clearText() {
        self.translatedText = ""
    }
    
    func triggerScanner () {
        self.startScanning = true
    }
}
