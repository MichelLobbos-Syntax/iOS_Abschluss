//
//  MovingGradientBackground.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 23.06.24.
//

import SwiftUI

struct AnimatedBackground: View {
    @State private var circlesOffset: CGFloat = 0
    @State private var gradientOffset: CGFloat = 0
    @State private var colors: [Color] = [.blue, .purple, .pink, .blue, .purple, .pink]
    @State private var animateGradient = false

    private let numberOfCircles = 20
    private let circleSizeRange: ClosedRange<CGFloat> = 10...30
    private let animationDuration = 10.0

    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: colors),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
//                .animation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: true), value: animateGradient)
                .onAppear {
                    self.animateGradient.toggle()
                }
//                .offset(x: gradientOffset, y: -gradientOffset)

            ForEach(0..<numberOfCircles, id: \.self) { index in
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: CGFloat.random(in: self.circleSizeRange),
                           height: CGFloat.random(in: self.circleSizeRange))
                    .offset(x: self.circlesOffset + CGFloat(index * 10), y: CGFloat(index * 20))
                    .blendMode(.overlay)
                    .animation(Animation.easeInOut(duration: self.animationDuration).repeatForever(), value: circlesOffset)
                    .padding()
                    .onAppear {
                        self.circlesOffset += 10
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AnimatedBackground_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackground()
    }
}
