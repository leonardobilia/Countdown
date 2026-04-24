//
//  TimerBackdrop.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct TimerBackdrop: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(.systemBackground),
                Color(.secondarySystemBackground),
                Color(.systemTeal).opacity(0.18),
                Color(.systemOrange).opacity(0.16)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    TimerBackdrop()
}
