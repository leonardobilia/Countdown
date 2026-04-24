//
//  CircularProgressView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct CircularProgressView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(CountdownModel.self) private var model
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.white.opacity(0.5), lineWidth: 18)

            Circle()
                .stroke(Color(.separator).opacity(0.3), lineWidth: 1)

            if model.progress > 0 {
                Circle()
                    .trim(from: 0, to: model.progress)
                    .stroke(
                        AngularGradient(
                            colors: [
                                Color(.systemOrange),
                                Color(.systemPink),
                                Color(.systemTeal)
                            ],
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: 18, lineCap: .round, lineJoin: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.smooth(duration: 0.35), value: model.progress)
            }

            if model.progress == 1 {
                Circle()
                    .stroke(Color(.systemGreen), lineWidth: 18)
                    .transition(.opacity)
            }
        }
        .frame(width: size, height: size)
        .padding(28)
        .glassEffect(.regular, in: Circle())
    }
    
    private var size: CGFloat {
        horizontalSizeClass == .compact ? 255 : 540
    }
}

#Preview {
    let model = CountdownModel()
    model.selectedMinutes = 10
    model.updateDurationFromSelection()
    model.elapsedSeconds = 240

    return CircularProgressView()
        .environment(model)
}
