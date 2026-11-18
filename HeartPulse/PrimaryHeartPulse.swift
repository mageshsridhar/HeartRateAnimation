//
//  PrimaryHeartPulse.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/5/24.
//

import SwiftUI

struct PrimaryHeartPulse: View {
    /// Set to true to show the layer-by-layer breakdown next to the watch (used for the breakdown video).
    private let showBreakdown = false

    private static let deviceWidth: CGFloat = UIScreen.main.bounds.width
    private static let deviceHeight: CGFloat = UIScreen.main.bounds.height
    /// Resting size of the primary heart.
    private static let heartSize: Double = deviceWidth / 9

    @State private var wiggleAnimate = false
    @State private var redHeartWidth: Double = heartSize
    @State private var redHeartAnimatingHeight: Double = 0
    @State private var redHeartHeight: Double = heartSize

    private var deviceWidth: CGFloat { Self.deviceWidth }
    private var deviceHeight: CGFloat { Self.deviceHeight }

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                if showBreakdown {
                    BreakdownView(wiggleAnimate: $wiggleAnimate, redHeartAnimatingHeight: $redHeartAnimatingHeight, redHeartWidth: $redHeartWidth, redHeartHeight: $redHeartHeight)
                }
                ZStack {
                    Image("watchUltra")
                        .resizable()
                        .scaledToFit()
                        .frame(width: deviceWidth/2, height: deviceHeight/1.4)
                    Group {
                        HeartPulses(redHeartWidth: Self.heartSize, blackHeartWidth: deviceWidth/10, expandSizeTo: deviceWidth/3.5)
                            .cornerRadius(deviceHeight/7.4)
                        ExpandingHeartView(animatingHeight: $redHeartAnimatingHeight, width: $redHeartWidth, height: $redHeartHeight, color: .red)
                            .scaleEffect(wiggleAnimate ? 1.03 : 1)
                        SideGlowHeart(wiggleAnimate: $wiggleAnimate, width: deviceWidth/8.56, height: deviceWidth/9.5)
                        InnerShadowHeart(wiggleAnimate: $wiggleAnimate, width: deviceWidth/15, height: deviceWidth/9.8, color: .black)
                    }
                    .clipped()
                    .frame(maxWidth: deviceWidth/4.2, maxHeight: deviceHeight/2.4)
                }
                .frame(maxWidth: deviceWidth/2.5, maxHeight: deviceHeight/1.25)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(.black, in: RoundedRectangle(cornerRadius: 35, style: .continuous))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        // Beats once a second; the task is cancelled automatically when the view disappears.
        .task {
            while !Task.isCancelled {
                beat()
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }

    private func beat() {
        withAnimation(.spring(Spring(duration: 0.2, bounce: 0.8))) {
            redHeartAnimatingHeight = 35
            redHeartHeight = Self.heartSize
            redHeartWidth = Self.heartSize
            wiggleAnimate = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(Spring(duration: 0.4, bounce: 0.8))) {
                wiggleAnimate = false
                redHeartAnimatingHeight = 0
                redHeartHeight = Self.heartSize - 3
                redHeartWidth = Self.heartSize - 3
            }
        }
    }
}

#Preview {
    PrimaryHeartPulse()
}
