//
//  TracksQueueViewModel.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import Foundation
import Combine

class TracksQueueViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    func removeTrack(posId: String) {

        let url = URL(string: "\(Constants.baseUrl)/tracks-queue/\(posId)")

        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, error in
                        DispatchQueue.main.async {
                            if let error = error {
//                                self.error = error
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
                                print(error.localizedDescription)
                                return
                            }
                        }
                    }
                    .resume()

        }
    }
}
