//
//  TracksQueries.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import Foundation

func fetchMetadata() async throws -> SongMetadata {
  let url = URL(string: "https://example.com/tracks/01/meta")!
  let (data, _) = try await URLSession.shared.data(from: url)
  let metadata = try JSONDecoder().decode(SongMetadata.self, from: data)
  return metadata
}
