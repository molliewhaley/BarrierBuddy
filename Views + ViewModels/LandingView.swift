//
//  LandingView.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/5/23.
//

import SwiftUI
import SSSwiftUIGIFView

struct LandingView: View {
    
    var body: some View {
        SwiftUIGIFPlayerView(gifName: "HelloAnimation-9")
            .ignoresSafeArea(.all)
            .scaledToFill()
    }
}
