//
//  ExpandingHearts.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/7/24.
//

import SwiftUI

struct ExpandingHearts: View {
    @State private var expandBlackHeart = false
    @State var redHeartWidth: Double
    @State var blackHeartWidth: Double
    @State var redHeartHeight: Double = 0
    @State private var blackHeartHeight: Double = 0
    let expandSizeTo: Double
    func expandHearts() {
        withAnimation(.easeOut(duration: 3.5)) {
                redHeartWidth = expandSizeTo
                redHeartHeight = expandSizeTo
            }
        withAnimation(.easeOut(duration: 3.5).delay(0.3)) {
                blackHeartWidth = expandSizeTo
                blackHeartHeight = expandSizeTo
                expandBlackHeart = true
        }
    }
    
    var body: some View {
        ZStack {
            ExpandingHeartView(animatingHeight: $redHeartHeight, width: $redHeartWidth, height: $redHeartWidth, color: .red)
                .blur(radius: 5)
                .opacity(expandBlackHeart ? 0 : 1)
            ExpandingHeartView(animatingHeight: $blackHeartHeight, width: $blackHeartWidth, height: $blackHeartWidth, color: .black)
                .blur(radius: expandBlackHeart ? 40 : 20)
        }
        .frame(width: expandSizeTo, height: expandSizeTo)
        .onAppear() {
               expandHearts()
            }
    }
}

struct ExpandingHeartView: View {
    @Binding var animatingHeight: Double
    @Binding var width: Double
    @Binding var height: Double
    let color: Color
    var body: some View {
        HeartShape(heightValue: animatingHeight)
            .fill(color)
            .scaledToFit()
            .frame(width: width, height: height)
            .frame(maxWidth: width + 20, maxHeight: height + 20)
    }
}

struct HeartShape: Shape {
    var heightValue: Double
    var animatableData: Double {
        get { heightValue }
        set { heightValue = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.5*width, y: height))
        path.addCurve(
            to: CGPoint(x: 0.99996*width, y: 0.35029*height),
            control1: CGPoint(x: 0.82031*width, y: 0.79573*height + (heightValue/4.91)),
            control2: CGPoint(x: 0.99996*width, y: 0.57531*height + (heightValue/4.91))
        )
        
        path.addCurve(to: CGPoint(x: 0.71941*width, y: 0.03203*height), control1: CGPoint(x: 0.99996*width, y: 0.16431*height), control2: CGPoint(x: 0.87757*width, y: 0.03203*height))
        
        path.addCurve(
            to: CGPoint(x: 0.49998*width, y: 0.13*height - heightValue/10),
            control1: CGPoint(x: 0.62091*width, y: 0.03203*height ),
            control2: CGPoint(x: 0.54548*width, y: 0.08921*height - heightValue/16)
        )
        
        path.addCurve(
            to: CGPoint(x: 0.28055*width, y: 0.03203*height),
            control1: CGPoint(x: 0.45502*width, y: 0.08976*height - heightValue/16),
            control2: CGPoint(x: 0.37905*width, y: 0.03203*height))
        
        path.addCurve(to: CGPoint(x: 0, y: 0.35029*height), control1: CGPoint(x: 0.12238*width, y: 0.03203*height), control2: CGPoint(x: 0, y: 0.16431*height))
        
        path.addCurve(
            to: CGPoint(x: 0.5*width, y: height),
            control1: CGPoint(x: 0, y: 0.57531*height + (heightValue/4.91)),
            control2: CGPoint(x: 0.17954*width, y: 0.79573*height + (heightValue/4.91))
        )
        path.closeSubpath()
        return path
    }
}
#Preview {
    ExpandingHearts(redHeartWidth: 100, blackHeartWidth: 100, expandSizeTo: 300)
}
