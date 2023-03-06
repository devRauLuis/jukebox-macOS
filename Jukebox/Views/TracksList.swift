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
    @State private var search: String = ""
    @FocusState private var searchIsFocused: Bool

    var body: some View {

        VStack {

            if let filteredTracks = filteredTracks {
                TextField(
                        "Search",
                        text: $search
                )
                        .focused($searchIsFocused)
                        .onChange(of: search) { search in
                            if search.isEmpty {
                                self.filteredTracks = self.tracks
                            } else {
                                self.filteredTracks = tracks?.filter { track in
                                    track.title.lowercased().contains(search.lowercased())
                                }
                            }
                        }
                        .disableAutocorrection(true)
                        .cornerRadius(2)
                        .frame(height: 40)
                        .font(.system(size: 18, weight: .semibold))
                List(filteredTracks) { track in
                    TrackRow(track: track, handleAdd: { addTrackToQueue(trackName: track.songName) })
                }
            } else {
                VStack(alignment: .center) {
                    Text("No tracks in store")
                }
            }

        }
                .onAppear {
                    fetchTracks()
                }
    }


    func addTrackToQueue(trackName: String) {
        let url = URL(string: Constants.baseUrl + "/tracks-queue")!
        let payload = ["name": trackName]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let session = URLSession(configuration: .default)

        session.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                        print("Error: HTTP status code \(httpResponse.statusCode)")
                        return
                    }
                    print("Track added to queue")
                }
                .resume()
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
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession(configuration: .default)
//
        session.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    print("data \(String(data: data, encoding: .utf8))")
                    do {
                        let decoder = JSONDecoder()
                        let tracks = try decoder.decode([Track].self, from: data)
                        print("all decoded tracks \(tracks)")
                        DispatchQueue.main.async {
                            self.tracks = tracks
                            self.filteredTracks = self.tracks
                        }
                    } catch let error {
                        print("Error decoding response: \(error.localizedDescription)")
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

struct TracksRes: Decodable {
    var tracks: [Track]
}
