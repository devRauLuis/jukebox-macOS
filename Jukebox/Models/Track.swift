//
//  SongMetadata.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import Foundation

struct Track: Hashable, Codable, Identifiable {
    let songName: String
    let title: String
    let trackNumber: String
    let genre: String
    let artist: String
    let releaseTime: String
    let year: String
    let album: String
    let image: String?
    let id = UUID()
    let posId: String?
}
