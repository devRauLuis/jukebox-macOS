//
// Created by Raúl Luis on 4/3/23.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    @Published var metadata: Track?
    @Published var error: Error?
    @Published var isPlaying = false
    @Published var currentTime: Double = 0.0
    @Published var totalTime: Double = 0.0
    @Published var progress: Double = 0.0
    
    var isBuffering: Bool {
        guard let currentItem = player?.currentItem else {
            return false
        }
        
        return currentItem.status == .unknown
    }
    
    private var player: AVPlayer?
    private var timeObserver: Any?

    func setupAudioPlayer(with songId: String, handleSongEnd: @escaping () -> Void) {
        let encodedTrack = songId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        player = AVPlayer(url: URL(string: "\(Constants.baseUrl)/tracks/stream/\(encodedTrack)")!)
//        print("Audio player setup \(player?.currentItem) \(Constants.baseUrl)/tracks/stream/\(encodedTrack)")
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else {
                return
            }
            
            let currentSeconds = time.seconds
            let durationSeconds = self.player?.currentItem?.duration.seconds ?? 0.0
            self.currentTime = currentSeconds
            self.totalTime = durationSeconds
            self.progress = currentSeconds / durationSeconds
            if self.progress == 1 {
                handleSongEnd()
            }
        }
    }

    func fetchMetadata(for track: String) {
        print("Fetch metadata called for \(track)")
        let encodedTrack = track.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: "\(Constants.baseUrl)/tracks/\(encodedTrack)/meta") else {
            print("Error with url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)

        session.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Fetch metadata error: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    if let decodedTrack = try? JSONDecoder().decode(Track.self, from: data) {
                        DispatchQueue.main.async {
                            self.metadata = decodedTrack
                            print("updated metadata: \(self.metadata?.songName)")
                        }
                    } else {
                        print("Failed to decode track")
                    }
                }
                .resume()
    }

    func play() {
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func cleanupAudioPlayer() {
        player = nil
        timeObserver = nil
    }
}
