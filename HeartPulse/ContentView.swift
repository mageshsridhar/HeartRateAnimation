//
//  ContentView.swift
//  HeartPulse
//
//  Created by Magesh Sridhar on 9/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wiggleAnimate = false
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .frame(width: wiggleAnimate ? 240 : 228, height: wiggleAnimate ? 240 : 230)
            .padding()
            .onAppear {
                
            }
            .onReceive(timer) { _ in
                withAnimation(.spring(Spring(duration: 0.2, bounce: 0.8))) {
                    wiggleAnimate = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.spring(Spring(duration: 0.4, bounce: 0.8))) {
                        wiggleAnimate = false
                    }
                }
            }
            .onDisappear {
                self.timer.upstream.connect().cancel()
            }
    }
}

#Preview {
    ContentView()
}
