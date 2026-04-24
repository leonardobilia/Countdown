//
//  ClockView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct ClockView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(CountdownModel.self) private var model
    
    var body: some View {
        VStack(spacing: 8) {
            Text(model.timeFormatter)
                .font(font)
                .monospacedDigit()
                .foregroundStyle(.primary)

            Text(model.isRunning ? "Running" : "Ready")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 18)
        .glassEffect(.regular, in: .rect(cornerRadius: 24, style: .continuous))
    }
    
    private var font: Font {
        horizontalSizeClass == .compact ? .largeTitle : .system(size: 68, weight: .bold, design: .default)
    }
}

#Preview {
    let model = CountdownModel()
    model.selectedMinutes = 5
    model.updateDurationFromSelection()

    return ClockView()
        .environment(model)
}
