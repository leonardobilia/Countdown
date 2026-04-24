//
//  SystemSounds.swift
//  Countdown
//
//  Created by Leonardo Bilia on 16/08/20.
//

import Foundation

struct SystemSounds: Identifiable {
    let id: Int
    let title: String
}

extension SystemSounds {
    static let all: [SystemSounds] = [.none, .alarm, .anticipate, .bloom, .calypso, .minuet, .suspense, .tweet]
    
    static let none = SystemSounds(id: 0, title: "None")
    static let alarm = SystemSounds(id: 1005, title: "Alarm")
    static let tweet = SystemSounds(id: 1016, title: "Tweet")
    static let anticipate = SystemSounds(id: 1320, title: "Anticipate")
    static let bloom = SystemSounds(id: 1321, title: "Bloom")
    static let calypso = SystemSounds(id: 1322, title: "Calypso")
    static let minuet = SystemSounds(id: 1327, title: "Minuet")
    static let suspense = SystemSounds(id: 1332, title: "Suspense")
}
