//
//  TracksList.swift
//  Jukebox
//
//  Created by Raúl Luis on 5/3/23.
//

import SwiftUI

struct TracksList: View {
    @State private var tracks: [Track]?
    @State private var filteredTracks: [Track]?
    
    var body: some View {
        VStack {
            
        }
    }
    
    func fetchTracks() {
        print("Fetch tracks")
//        let encodedTrack = track.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: "\(Constants.baseUrl)/tracks") else {
            print("Error with url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)

        session.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Fetch tracks error: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    if let decodedTracks = try? JSONDecoder().decode([Track].self, from: data) {
                        DispatchQueue.main.async {
                            self.tracks = decodedTracks
                        }
                    } else {
                        print("Failed to decode tracks")
                    }
                }
                .resume()
    }

}

struct TracksList_Previews: PreviewProvider {
    static var previews: some View {
        TracksList()
    }
}
