//
//  CountdownModel.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI
import AVFoundation

class CountdownModel: ObservableObject {
    
    // MARK: - Publishers
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var sounds = SystemSounds.all
    @Published var counter: CGFloat = 0.0
    @Published var duration: CGFloat = 0.1
    @Published var storedDuration: CGFloat = 0.1
    
    @Published var selectedHours = 0
    @Published var selectedMinutes = 0
    @Published var selectedSeconds = 0
    
    @Published var isRunning = false
    
    // MARK: - Properties
    
    var progress: CGFloat {
        (counter / duration)
    }
    
    var timeFormatter: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: TimeInterval(duration - counter)) ?? "00:00:00"
    }
    
    // MARK: - Methods
    
    func completed(with sound: SystemSounds.ID) -> Bool {
        AudioServicesPlaySystemSound(SystemSoundID(progress == 1 && isRunning ? sound : 0))
        return progress == 1
    }
    
    func timeInSeconds() {
        let hours = selectedHours * 3600
        let minutes = selectedMinutes * 60
        let seconds = selectedSeconds
        counter = 0
        duration = CGFloat(hours + minutes + seconds)
    }
    
    func updateTimer(_ tag: Int) {
        timeInSeconds()
    }
    
    func previewAudio(_ tag: SystemSounds.ID) {
        AudioServicesPlaySystemSound(SystemSoundID(tag))
    }
    
    func resetTimer() {
        isRunning = false
        duration = storedDuration
        counter = 0
    }
    
    func receiveTimerUpdate() {
        if counter < duration && isRunning {
            counter += 1
        } else {
            isRunning = false
            timer.upstream.connect().cancel()
        }
    }
    
    func disabledAction() -> Bool {
        duration == 0.1
    }
    
    func playPauseAction() {
        isRunning.toggle()
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
}
