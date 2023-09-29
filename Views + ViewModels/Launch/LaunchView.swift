//
//  LaunchView.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/14/23.
//

import SwiftUI
import VisionKit

struct LaunchView: View {
    @StateObject private var launchVM = LaunchVM()
    
    var body: some View {
        ZStack {
            if !launchVM.goToFlags {
                LandingView()
            } else {
                FlagChoicesView()
            }
        }
        .onAppear {
            if launchVM.isSupported() {
                launchVM.handleLaunchAnimation()
            }
        }
        .alert(isPresented: $launchVM.triggerAlert, content: {
            Alert(title: Text("Alert"), message: Text(launchVM.alertMessage), dismissButton: .default(Text("OK")) {
                launchVM.toggleAlert()
            })
        })
    }
}

