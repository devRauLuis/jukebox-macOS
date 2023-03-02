//
//  AudioPlayerViewModel.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    @Published var isPlaying = false
    @Published var currentTimeString = "00:00"
    @Published var totalTimeString = "00:00"
    @Published var progress: Float = 0

    private var player: AVPlayer?
    private var timeObserver: Any?

    deinit {
        cleanupAudioPlayer()
    }

    func setupAudioPlayer(with songId: String) {
        let url = "http://localhost:8080/tracks/stream/\(songId)"

        guard let audioURL = URL(string: url) else {
            print("Error: Audio file not found")
            return
        }

        let playerItem = AVPlayerItem(url: audioURL)
        player = AVPlayer(playerItem: playerItem)

        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else {
                return
            }
            self.currentTimeString = minuteSecondString(from: time)

            let duration = self.player?.currentItem?.duration

            if let unwrappedDuration = duration {
                // use the unwrappedTime variable of type CMTime                print(unwrappedDuration.seconds)
                self.totalTimeString = minuteSecondString(from: unwrappedDuration)

                let progressCalc = Float(time.seconds) / Float(unwrappedDuration.seconds)

                self.progress = progressCalc.isNaN || progressCalc.isInfinite ? 0 : max(0, min(1, progressCalc))
            }

        }
    }

    func cleanupAudioPlayer() {
        player?.pause()
        player = nil
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }
    }

    func togglePlayPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
}
