//
//  SettingsView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("SelectedSystemSound") private var sound: SystemSounds.ID = 1005
    @Environment(\.dismiss) private var dismiss
    @Environment(CountdownModel.self) private var model

    private let hours = [Int](0...23)
    private let minutes = [Int](0...59)
    private let seconds = [Int](0...59)

    var body: some View {
        @Bindable var model = model

        NavigationStack {
            Form {
                Section("Timer") {
                    Picker("Hours", selection: $model.selectedHours) {
                        ForEach(hours, id: \.self) { hour in
                            Text("\(hour)")
                        }
                    }

                    Picker("Minutes", selection: $model.selectedMinutes) {
                        ForEach(minutes, id: \.self) { minute in
                            Text("\(minute)")
                        }
                    }

                    Picker("Seconds", selection: $model.selectedSeconds) {
                        ForEach(seconds, id: \.self) { second in
                            Text("\(second)")
                        }
                    }
                }

                Section("Sound") {
                    Picker("Alert", selection: $sound) {
                        ForEach(model.sounds, id: \.id) { audio in
                            Text(audio.title).tag(audio.id)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: model.selectedHours) { _, _ in model.updateDurationFromSelection() }
            .onChange(of: model.selectedMinutes) { _, _ in model.updateDurationFromSelection() }
            .onChange(of: model.selectedSeconds) { _, _ in model.updateDurationFromSelection() }
            .onChange(of: sound) { _, newValue in model.previewAudio(newValue) }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(CountdownModel())
}
