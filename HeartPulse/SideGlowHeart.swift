//
//  SideGlowHeart.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/28/24.
//

import SwiftUI

struct SideGlowHeart: View {
    @Binding var wiggleAnimate: Bool
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Image(systemName: "heart")
            .resizable()
            .foregroundStyle(.yellow)
            .fontWeight(.ultraLight)
            .opacity(wiggleAnimate ? 0.7 : 0.5)
            .blur(radius: 2)
            .frame(width: wiggleAnimate ? width : width - 8, height: wiggleAnimate ? height : height - 8)
            .frame(maxWidth: width + 15, maxHeight: height + 15)
            .mask(LinearGradient(stops: [.init(color: .black, location: 0),.init(color: .clear, location: 0.25), .init(color: .clear, location: 0.75), .init(color: .black, location: 1)], startPoint: .leading, endPoint: .trailing))
            .blendMode(.plusLighter)
            .offset(x: 2)
    }
}
