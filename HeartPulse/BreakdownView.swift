//
//  BreakdownView.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/28/24.
//

import SwiftUI

struct BreakdownView : View {
    @Binding var wiggleAnimate: Bool
    @Binding var redHeartAnimatingHeight: Double
    @Binding var redHeartWidth: Double
    @Binding var redHeartHeight: Double
    var body: some View {
        VStack(spacing: 20) {
            ExpandingHeartView(animatingHeight: $redHeartAnimatingHeight, width: $redHeartWidth, height: $redHeartHeight, color: .red)
            .scaleEffect(wiggleAnimate ? 1.03 : 1)
                .padding()
                .frame(width: 150, height: 150)
                .background(.black, in: RoundedRectangle(cornerRadius: 20))
            SideGlowHeart(wiggleAnimate: $wiggleAnimate, width: 240, height: 240)
                .scaleEffect(0.5)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 150, height: 150)
                .background(.black, in: RoundedRectangle(cornerRadius: 20))
            InnerShadowHeart(wiggleAnimate: $wiggleAnimate, width: 160, height: 240, color: .white)
                .scaleEffect(0.5)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 150, height: 150)
                .background(.black, in: RoundedRectangle(cornerRadius: 20))
            HeartPulses(redHeartWidth: 50, blackHeartWidth: 50, expandSizeTo: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 150, height: 150)
                .background(.black, in: RoundedRectangle(cornerRadius: 20))
        }
    }
}
