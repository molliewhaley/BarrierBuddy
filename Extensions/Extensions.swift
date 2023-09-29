//
//  Extensions.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/21/23.
//

import SwiftUI

extension Text {
    func boxForTranslation() -> some View {
        self
            .padding()
            .font(Font.custom("Oswald-Regular", size: 30))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
            .background(in: Rectangle())
    }
}

extension Font {
    static func oswald(size: CGFloat) -> Font {
        return Font.custom("Oswald-Regular", size: size)
    }
}

extension Double {
    func twoDecimalRound() -> String {
           return String(format: "%.2f", self)
       }
}
