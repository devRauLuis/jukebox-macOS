//
//  TracksQueueViewModel.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import Foundation
import Combine

class TracksQueueViewModel: ObservableObject {
    @Published var queue: [Track] = []
    @Published var currentTrack: Track?
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()

    func addTrackToQueue(trackName: String) {
        let url = URL(string: Constants.baseUrl + "/tracks-queue")!
        let payload = ["name": trackName]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
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

    
    func removeTrack(posId: String) {

        let url = URL(string: "\(Constants.baseUrl)/tracks-queue/\(posId)")

        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                self.error = error
                                print(error.localizedDescription)
                                return
                            }
                        }
                    }
                    .resume()

        }
    }

    func queueRandomTrack() {
        let url = URL(string: "\(Constants.baseUrl)/tracks-queue/queue-random-track")
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            URLSession.shared.dataTask(with: request) { data, response, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                self.error = error
                                print(error.localizedDescription)
                                return
                            }
                        }
                    }
                    .resume()

        }
    }
}
