//
//  SongMetadataFetcher.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import Foundation
import Combine

class MetadataFetcher: ObservableObject {
    @Published var metadata: SongMetadata?

    private var cancellables = Set<AnyCancellable>()

    
    func fetchMetadata(for track: String) {
//        let url = URL(string: "http://localhost:8080/tracks/\(track)/meta")!
        
        //        URLSession.shared.dataTask(with: url) { data, response, error in
        //            do {
        //                let decoder = JSONDecoder()
        //                return try decoder.decode(SongMetadata.self, from: data)
        //            } catch {
        //                fatalError("Couldn't parse \(url) as \(SongMetadata.self):\n\(error)")
        //            }
        //        }
        
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: SongMetadata?.self, decoder: JSONDecoder())
//            .replaceError(with: nil)
//            .receive(on: DispatchQueue.main)
//            .assign(to: &$metadata)
        //        if let metadata = $metadata., let imageData = metadata.imageData {
        //            print("imageData: \(imageData)")
        //        }
        //
        let url = URL(string: "http://localhost:8080/tracks/\(track)/meta")!
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: SongMetadata?.self, decoder: JSONDecoder())
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] metadata in
                    self?.metadata = metadata
                    self?.logMetadata()
                }
                .store(in: &cancellables)
    }
    
    private func logMetadata() {
        if let metadata = metadata {
            print("title: \(metadata.title)")
            print("artist: \(metadata.artist)")
            print("album: \(metadata.album)")
            if let imageData = metadata.image {
                print("imageData: \(imageData)")
            }
        } else {
            print("metadata is nil")
        }
    }
}
