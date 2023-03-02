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
    let songId: String
    
    @ObservedObject private var player = AudioPlayerViewModel()
    @ObservedObject private var metadataFetcher = MetadataFetcher()
    
    var body: some View {
        
        VStack {
            if let metadata = metadataFetcher.metadata {
                // display image (if available)
                if let imageData = metadata.image {
                    Base64ImageView(base64: imageData)
                }
                VStack(alignment: .leading) {
                    Text(metadata.title).font(.title).bold()
                    Text(metadata.artist).font(.subheadline)
                }
                ProgressBar(currentTime: player.currentTimeString, totalTime: player.totalTimeString, progress: player.progress)
            } else {
                // display loading spinner while metadata is fetched
                ProgressView()
            }
            
            HStack {
                PrevButton(handleClick: {})
                    .padding(.trailing)
                PlayPauseButton(isPlaying: player.isPlaying, togglePlaying: player.togglePlayPause)
                    .padding(.trailing)
                NextButton(handleClick: {})
            }
            .padding(.top)
        }
        .padding(.all)
        
        .onAppear {
            player.setupAudioPlayer(with: songId)
            metadataFetcher.fetchMetadata(for: songId)
        }
        
        .onDisappear {
            player.cleanupAudioPlayer()
        }
    }
    
}

struct AudioPlayer_Previews: PreviewProvider {
    static var previews: some View {
        let metadata = SongMetadata(title: "Song Title", trackNumber: "1", genre: "Pop", artist: "Artist Name", releaseTime: "2022-02-28T00:00:00Z", year: "2022", album: "Album Title", image: "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAIAAADTED8xAAADMElEQVR4nOzVwQnAIBQFQYXff81RUkQCOyDj1YOPnbXWPmeTRef+/3O/OyBjzh3CD95BfqICMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMO0TAAD//2Anhf4QtqobAAAAAElFTkSuQmCC")
        
        let metadataFetcher = MetadataFetcher()
        metadataFetcher.metadata = metadata
        
        let player = AudioPlayerViewModel()
        player.setupAudioPlayer(with: "https://example.com/audio.mp3")
        
        return AudioPlayer(songId: "")
            .environmentObject(player)
            .environmentObject(metadataFetcher)
    }
}
