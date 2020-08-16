//
//  ContentView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CountdownModel
    @State private var showSettings = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    CircularProgressView()
                    ClockView()
                }
            
                HStack {
                    Button(action: { model.resetTimer() }) {
                        CircleButton(style: .reset)
                    }
                    Spacer()
                    Button(action: { model.playPauseAction() }) {
                        CircleButton(style: model.isRunning ? .pause : .start)
                    }.disabled(model.disabledAction())
                }
                .padding()
            }
            .onReceive(model.timer) { time in
                model.receiveTimerUpdate()
            }
            .navigationTitle("Countdown")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings.toggle()
                        model.isRunning = false
                    }) {
                        Label("Settings", systemImage: "gearshape.fill")
                            .labelStyle(IconOnlyLabelStyle())
                    }
                    .sheet(isPresented: $showSettings, onDismiss: {
                        model.storedDuration = model.duration
                    }) {
                        SettingsView()
                            .environmentObject(model)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CountdownModel())
    }
}
