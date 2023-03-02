//
//  PlayButton.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import SwiftUI

struct PlayPauseButton: View {
    var isPlaying: Bool
    var togglePlaying: () -> Void
    var body: some View {
        Button(action: togglePlaying) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: 32.0))
                .foregroundColor(.gray)
        }
        .buttonStyle(.plain)
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButton(isPlaying: true, togglePlaying: {})
    }
}
