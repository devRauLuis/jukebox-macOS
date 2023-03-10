//
//  AudioPlayer.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import AVFoundation
import SwiftUI
import AppKit

struct AudioPlayer: View {
    var toggleError: (Bool?) -> Void
    @StateObject var audioManager = AudioManager()
    var queue: [Track]?
    var queueRandomTrack: () -> Void
    @State var volume: Double = 1
    @State var mute: Bool = false
    
    private var songProgress: Binding<Double> {
        Binding(
            get: { audioManager.progress },
            set: { newVal in
                audioManager.sliderValueChanged(editingChanged: true, newProgress: newVal)
                print("progress \(newVal)")
                if newVal >= 1 {
                    popQueue()
                }
            })
    }
    
    var body: some View {
        VStack {
            if audioManager.isBuffering {
                ProgressView()
            } else {
                VStack {
                    Base64ImageView(base64: audioManager.metadata?.image)
                    Text(audioManager.metadata?.title ?? "").font(.title).bold()
                    Text(audioManager.metadata?.artist ?? "").font(.subheadline)
                    HStack {
                        Text(formatTimeString(from: audioManager.currentTime))
                        
                        Slider(value: songProgress)
                        Text(formatTimeString(from: audioManager.totalTime))
                    }
                    HStack {
                        PlayPauseButton(isPlaying: audioManager.isPlaying, togglePlaying: {
                            if audioManager.isPlaying {
                                audioManager.pause()
                            } else {
                                audioManager.play()
                            }
                        })
                        .padding(.trailing)
                        NextButton(handleClick: {
                            audioManager.pause()
                            popQueue()
                        })
                    }
                    .padding(.top)
                    HStack {
                        Button(action: {
                            mute.toggle()
                            audioManager.mute(to: mute)
                        }) {
                            Image(systemName: mute ? "volume.slash.fill" : "volume.3.fill"
                            ).foregroundColor(.gray).font(.system(size: 12))
                        }
                        .buttonStyle(.plain)
                        Slider(value: $volume, onEditingChanged: volumeChanged)
                            .disabled(mute)
                    }
                    .padding(.top)
                    .padding(.horizontal, 40)
                }
            }
        }
        .onChange(of: queue, perform: { newQueue in
            print("queue changed \(newQueue?.count)")
            if let firstSong = newQueue?.first {
                print("first songs: \(firstSong.posId) \(firstSong.songName) - \(audioManager.metadata?.posId) \(audioManager.metadata?.title)")
                if audioManager.metadata?.posId == firstSong.posId {
                    // The first song in the new queue is the same as the currently playing song, do nothing
                } else {
                    // Queue is not empty and the first song is different, play the first song
                    audioManager.cleanupAudioPlayer()
                    audioManager.fetchMetadata(for: firstSong.songName, posId: firstSong.posId)
                    audioManager.setupAudioPlayer(with: firstSong.songName, handleSongEnd: popQueue)
                    audioManager.play()
                }
            } else {
                // Queue is empty, queue a new song
                queueRandomTrack()
            }
        }).onChange(of: audioManager.progress) {progress in
            var currentTime = audioManager.currentTime.rounded()
            var totalTime = audioManager.totalTime.rounded()
            print("progress: \(progress) \(currentTime) \(totalTime)")
            
            if (currentTime > 0 && totalTime > 0) && currentTime == totalTime {
                popQueue()
            }}
    }
    
    func volumeChanged(editingChanged: Bool) {
        guard editingChanged else {
            return
        }
        audioManager.changePlayerVolume(to: volume)
    }
    
    //    func mute
    
    func popQueue() {
        audioManager.cleanupAudioPlayer()
        guard let url = URL(string: "\(Constants.baseUrl)/tracks-queue/pop") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let decodedTrack = try? JSONDecoder().decode(Track.self, from: data) {
                DispatchQueue.main.async {
                    print("decoded track: \(decodedTrack.songName)")
                }
            } else {
                print("Failed to decode track")
            }
        }
        .resume()
    }
}

struct AudioPlayer_Previews: PreviewProvider {
    static var previews: some View {
        let metadata = Track(songName: "01",
                             title: "Days Before Rodeo The Prequel",
                             trackNumber: "1",
                             genre: "",
                             artist: "Travis Scott",
                             releaseTime: "Travi$ Scott",
                             year: "Travi$ Scott",
                             album: "Days Before Rodeo",
                             image: nil,
                             posId: "abcdefghijk")
        
        return AudioPlayer(toggleError: { val in }, queue: [], queueRandomTrack: {})
    }
}
