//
//  CircleButton.swift
//  Countdown
//
//  Created by Leonardo Bilia on 16/08/20.
//

import SwiftUI

struct CircleButton: View {
    
    enum ButtonStyle {
        case start
        case pause
        case reset
        
        var title: String {
            switch self {
            case .start:
                return "Start"
            case .pause:
                return "Pause"
            case .reset:
                return "Reset"
            }
        }
        
        var fillColor: Color {
            switch self {
            case .start:
                return Color(.systemTeal)
            case .pause:
                return Color(.systemOrange)
            case .reset:
                return Color(.systemGray5)
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .start:
                return Color(.white)
            case .pause:
                return Color(.white)
            case .reset:
                return Color(.label)
            }
        }
    }
    
    var style: ButtonStyle
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: style.systemImage)
                .font(.system(size: 24, weight: .semibold))

            Text(style.title)
                .font(.caption.weight(.semibold))
        }
        .foregroundStyle(style.foregroundColor)
        .frame(width: 86, height: 86)
        .background(style.fillColor, in: Circle())
        .glassEffect(.regular.interactive(), in: Circle())
    }
}

private extension CircleButton.ButtonStyle {
    var systemImage: String {
        switch self {
        case .start:
            return "play.fill"
        case .pause:
            return "pause.fill"
        case .reset:
            return "arrow.counterclockwise"
        }
    }
}

#Preview {
    HStack {
        CircleButton(style: .reset)
        CircleButton(style: .start)
        CircleButton(style: .pause)
    }
    .padding()
}
