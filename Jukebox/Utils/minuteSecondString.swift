//
//  minuteSecondTring.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import Foundation
import AVFoundation

func formatTimeString(from time: Double) -> String {
    let totalSeconds = time;
    if !totalSeconds.isFinite {
        return "00:00"
    }
    let minutes = Int(totalSeconds / 60)
    let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
    return String(format: "%02d:%02d", minutes, seconds)
}
