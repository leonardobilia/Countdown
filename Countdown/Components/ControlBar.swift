//
//  ControlBar.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct ControlBar: View {

    let isRunning: Bool
    let canStart: Bool
    let reset: () -> Void
    let toggle: () -> Void

    var body: some View {
        GlassEffectContainer(spacing: 18) {
            HStack(spacing: 18) {
                Button(action: reset) {
                    CircleButton(style: .reset)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Reset timer")

                Button(action: toggle) {
                    CircleButton(style: isRunning ? .pause : .start)
                }
                .buttonStyle(.plain)
                .disabled(!canStart)
                .accessibilityLabel(isRunning ? "Pause timer" : "Start timer")
            }
        }
    }
}

#Preview {
    ControlBar(
        isRunning: false,
        canStart: true,
        reset: {},
        toggle: {}
    )
    .padding()
}
