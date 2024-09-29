//
//  PrimaryHeartPulse.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/5/24.
//

import SwiftUI

struct PrimaryHeartPulse: View {
    @State private var wiggleAnimate = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let deviceWidth: CGFloat = UIScreen.main.bounds.width
    let deviceHeight: CGFloat = UIScreen.main.bounds.height
    @State private var redHeartWidth: Double = UIScreen.main.bounds.width/9
    @State private var redHeartAnimatingHeight: Double = 0
    @State private var redHeartHeight: Double = UIScreen.main.bounds.width/9
    var body: some View {
        VStack {
            Text("Made by Magesh Sridhar using SwiftUI ❤️")
                .fontWeight(.medium)
                .font(.title2)
            HStack(spacing: 20) {
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
                ZStack {
                    InsideWatch()
                        .frame(width: deviceWidth/2, height: deviceHeight/1.4)
                    Group {
                        HeartPulses(redHeartWidth: UIScreen.main.bounds.width/9, blackHeartWidth: UIScreen.main.bounds.width/10, expandSizeTo: deviceWidth/3.5)
                            .scaleEffect(1)
                            .cornerRadius(deviceHeight/7.4)
                        ExpandingHeartView(animatingHeight: $redHeartAnimatingHeight, width: $redHeartWidth, height: $redHeartHeight, color: .red)
                            .scaleEffect(wiggleAnimate ? 1.03 : 1)
                        SideGlowHeart(wiggleAnimate: $wiggleAnimate, width: UIScreen.main.bounds.width/8.56, height: UIScreen.main.bounds.width/9.5)
                        InnerShadowHeart(wiggleAnimate: $wiggleAnimate, width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/9.8, color: .black)
                    }.clipped()
                        .frame(maxWidth: deviceWidth/4.2, maxHeight: deviceHeight/2.4)
                    
                        
                }
                .frame(maxWidth: deviceWidth/2.5, maxHeight: deviceHeight/1.25)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(.black, in: RoundedRectangle(cornerRadius: 30))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onReceive(timer) { _ in
                withAnimation(.spring(Spring(duration: 0.2, bounce: 0.8))) {
                    redHeartAnimatingHeight = 35
                    redHeartHeight = UIScreen.main.bounds.width/9
                    redHeartWidth = UIScreen.main.bounds.width/9
                    wiggleAnimate = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.spring(Spring(duration: 0.4, bounce: 0.8))) {
                        wiggleAnimate = false
                        redHeartAnimatingHeight = 0
                        redHeartHeight = (UIScreen.main.bounds.width/9) - 3
                        redHeartWidth = (UIScreen.main.bounds.width/9) - 3
                    }
                }
            }
            .onDisappear {
                self.timer.upstream.connect().cancel()
            }
    }
}

#Preview {
    PrimaryHeartPulse()
}
