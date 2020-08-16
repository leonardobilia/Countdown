//
//  CircularProgressView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI
import AVFoundation

struct CircularProgressView: View {

    @AppStorage("SelectedSystemSound") private var sound: SystemSounds.ID = 1005
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject private var model: CountdownModel
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: size, height: size)
            .overlay(Circle().stroke(Color(.secondarySystemBackground), lineWidth: 15))
            .overlay(overlayCircle)
    }
    
    private var overlayCircle: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .trim(from: 0, to: model.progress)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin:.round))
                    .rotationEffect(.degrees(-90))
                    .foregroundColor(Color(model.completed(with: sound) ? .systemGreen : .systemOrange))
                    .animation(.easeInOut(duration: 0.2))
            )
    }
    
    private var size: CGFloat {
        horizontalSizeClass == .compact ? 255 : 540
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
            .environmentObject(CountdownModel())
    }
}
