//
//  CountdownModel.swift
//  Countdown
//
//  Created by Leonardo Bilia on 15/08/20.
//

import SwiftUI
import Observation
import AudioToolbox

@MainActor
@Observable
final class CountdownModel {
    
    let sounds = SystemSounds.all

    var elapsedSeconds: TimeInterval = 0
    var duration: TimeInterval = 0
    var selectedHours = 0
    var selectedMinutes = 0
    var selectedSeconds = 0
    var isRunning = false

    @ObservationIgnored private var timerTask: Task<Void, Never>?

    var progress: CGFloat {
        guard duration > 0 else { return 0 }
        return min(CGFloat(elapsedSeconds / duration), 1)
    }

    var remainingSeconds: TimeInterval {
        max(duration - elapsedSeconds, 0)
    }

    var timeFormatter: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: remainingSeconds) ?? "00:00:00"
    }

    var canStart: Bool {
        duration > 0 && elapsedSeconds < duration
    }

    deinit {
        timerTask?.cancel()
    }

    func updateDurationFromSelection() {
        let hours = selectedHours * 3600
        let minutes = selectedMinutes * 60
        let seconds = selectedSeconds
        duration = TimeInterval(hours + minutes + seconds)
        elapsedSeconds = min(elapsedSeconds, duration)

        if duration == 0 {
            resetTimer()
        }
    }

    func previewAudio(_ sound: SystemSounds.ID) {
        play(sound)
    }

    func resetTimer() {
        pauseTimer()
        elapsedSeconds = 0
    }

    func pauseTimer() {
        isRunning = false
        timerTask?.cancel()
        timerTask = nil
    }

    func toggleTimer(sound: SystemSounds.ID) {
        isRunning ? pauseTimer() : startTimer(sound: sound)
    }

    private func startTimer(sound: SystemSounds.ID) {
        guard canStart else { return }

        isRunning = true
        timerTask?.cancel()
        timerTask = Task { @MainActor [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                guard !Task.isCancelled else { return }
                self?.advanceTimer(sound: sound)
            }
        }
    }

    private func advanceTimer(sound: SystemSounds.ID) {
        guard isRunning else { return }

        elapsedSeconds = min(elapsedSeconds + 1, duration)

        if elapsedSeconds >= duration {
            play(sound)
            pauseTimer()
        }
    }

    private func play(_ sound: SystemSounds.ID) {
        guard sound != SystemSounds.none.id else { return }
        AudioServicesPlaySystemSound(SystemSoundID(sound))
    }
}
