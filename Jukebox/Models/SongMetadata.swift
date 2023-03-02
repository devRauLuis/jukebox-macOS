//
//  SongMetadata.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import Foundation

struct SongMetadata: Hashable, Codable {
    let title: String
    let trackNumber: String
    let genre: String
    let artist: String
    let releaseTime: String
    let year: String
    let album: String
    let image: String?
}
