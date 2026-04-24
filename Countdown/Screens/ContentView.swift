//
//  ContentView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct ContentView: View {

    @AppStorage("SelectedSystemSound") private var sound: SystemSounds.ID = 1005
    @Environment(CountdownModel.self) private var model
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ZStack {
                TimerBackdrop()

                VStack(spacing: 32) {
                    ZStack {
                        CircularProgressView()
                        ClockView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 18)

                    ControlBar(
                        isRunning: model.isRunning,
                        canStart: model.canStart,
                        reset: resetTimer,
                        toggle: toggleTimer
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Countdown")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: showTimerSettings) {
                        Label("Settings", systemImage: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .presentationDetents([.medium, .large])
            }
        }
    }

    private func resetTimer() {
        model.resetTimer()
    }

    private func toggleTimer() {
        model.toggleTimer(sound: sound)
    }

    private func showTimerSettings() {
        model.pauseTimer()
        showSettings = true
    }
}

#Preview {
    let model = CountdownModel()
    model.selectedMinutes = 5
    model.updateDurationFromSelection()

    return ContentView()
        .environment(model)
}
