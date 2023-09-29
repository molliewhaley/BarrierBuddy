//
//  LaunchVM.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/23/23.
//

import SwiftUI
import VisionKit

extension LaunchView {
    @MainActor final class LaunchVM: ObservableObject {
        @Published private(set) var goToFlags = false
        @Published private(set) var alertMessage = ""
        @Published var triggerAlert = false
        
        func handleLaunchAnimation() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.55) {
                withAnimation {
                    self.goToFlags = true
                }
            }
        }
        
        func isSupported() -> Bool {
            if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                return true
            } else {
                self.toggleAlert()
                self.alertMessage = "Available features not available."
                return false
            }
        }
        
        func toggleAlert() {
            self.triggerAlert.toggle()
        }
    }
}
