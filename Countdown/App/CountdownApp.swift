//
//  CountdownApp.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

@main
struct CountdownApp: App {
    
    @State private var model = CountdownModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}
