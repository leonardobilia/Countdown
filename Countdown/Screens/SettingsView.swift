//
//  SettingsView.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    
    @AppStorage("SelectedSystemSound") private var sound: SystemSounds.ID = 1005
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var model: CountdownModel

    @State private var hours = [Int](0...23)
    @State private var minutes = [Int](0...59)
    @State private var seconds = [Int](0...59)

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Timer")) {
                    Picker("Hours", selection: $model.selectedHours.onChange(model.updateTimer)) {
                        ForEach(hours, id: \.self) { hour in
                            Text("\(hour)")
                        }
                    }
                    
                    Picker("Minutes", selection: $model.selectedMinutes.onChange(model.updateTimer)) {
                        ForEach(minutes, id: \.self) { minute in
                            Text("\(minute)")
                        }
                    }
                    
                    Picker("Seconds", selection: $model.selectedSeconds.onChange(model.updateTimer)) {
                        ForEach(seconds, id: \.self) { second in
                            Text("\(second)")
                        }
                    }
                }
                
                Section(header: Text("Sounds")) {
                    Picker("Sounds", selection: $sound.onChange(model.previewAudio)) {
                        ForEach(model.sounds, id: \.id) { audio in
                            Text(audio.title).tag(audio.id)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(CountdownModel())
    }
}
