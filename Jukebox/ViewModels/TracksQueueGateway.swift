//
//  TracksQueueGateway.swift
//  Jukebox
//
//  Created by Raúl Luis on 3/3/23.
//

import Foundation
import SocketIO
import Starscream

class  TracksQueueGateway: ObservableObject {
    let manager: SocketManager
    let socket:  SocketIOClient
    @Published var error: String?
    @Published var queue: [Track]?
    
    init() {
        manager = SocketManager(socketURL: URL(string: Constants.baseUrl)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.connect()
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on(clientEvent: .error) {data, ack in
            print("socket error \(data)")
            DispatchQueue.main.async {
                self.queue = nil
                self.error = data as? String
//                    print("Decoded tracks: \(self.queue)")
            }
        }
        
        socket.on("queueUpdated") { (dataArray, _) in
            print("initial data: \(dataArray)")
            
            print(type(of: dataArray))
            let decoder = JSONDecoder()
            
            do{
                let data = try JSONSerialization.data(withJSONObject: dataArray[0], options: [])
                let tracks = try decoder.decode([Track].self, from: data)
            
                DispatchQueue.main.async {
                    self.queue = tracks
                    print("Decoded tracks: \(self.queue)")
                }
            } catch {
                print("Error decoding tracks: \(error)")
            }
        
        }
        
    }
    
}
