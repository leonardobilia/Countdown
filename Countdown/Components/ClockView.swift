//
//  ClockView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct ClockView: View {
    
    @EnvironmentObject private var model: CountdownModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        VStack {
            Text(model.timeFormatter)
                .font(font)
                .fontWeight(.black)
        }
    }
    
    private var font: Font {
        horizontalSizeClass == .compact ? .largeTitle : .system(size: 68, weight: .bold, design: .default)
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
            .environmentObject(CountdownModel())
    }
}
