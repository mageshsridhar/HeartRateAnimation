//
//  HeartPulses.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/28/24.
//

import SwiftUI


struct HeartPulses: View {
    
    var redHeartWidth: Double
    var blackHeartWidth: Double
    var expandSizeTo: Double
    
    @State private var expandingHearts: [ExpandingHeart] = []
    
    func addHeart() {
        let expandingHeart = ExpandingHeart()
        expandingHearts.append(expandingHeart)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.8) {
            expandingHearts.removeAll(where: { $0.id == expandingHeart.id})
        }
    }
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1, paused: false)) { timeline in
            Canvas { context, size in
                for heart in expandingHearts {
                    if let resolvedView = context.resolveSymbol(id: heart.id) {
                        let centerX = size.width / 2
                        let centerY = size.height / 2
                        context.draw(resolvedView, at: CGPoint(x: centerX, y: centerY))
                    }
                }
            } symbols: {
                ForEach(expandingHearts) { heart in
                    ExpandingHearts(redHeartWidth: redHeartWidth, blackHeartWidth: blackHeartWidth, expandSizeTo: expandSizeTo)
                        .id(heart.id)
                }
            }.onChange(of: timeline.date) { oldValue, newValue in
                addHeart()
            }
        }
    }
}
