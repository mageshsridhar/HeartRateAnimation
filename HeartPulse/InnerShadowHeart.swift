//
//  InnerShadowHeart.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/28/24.
//

import SwiftUI

struct InnerShadowHeart: View {
    @Binding var wiggleAnimate: Bool
    var width: Double
    var height: Double
    var color: Color
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .foregroundStyle(color)
            .frame(width: wiggleAnimate ? width : width - 12, height: wiggleAnimate ? height : height - 10)
            .frame(maxWidth: width*1.5, maxHeight: height*1.5)
            .blur(radius: width/8)
            .opacity(0.4)
            .blendMode(color == .black ? .plusDarker : .normal)
    }
}
