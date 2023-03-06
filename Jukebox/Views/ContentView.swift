//
//  ContentView.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var error: Bool = false
    @StateObject private var viewModel = TracksQueueViewModel()
    @ObservedObject private var socket = TracksQueueGateway()

    var body: some View {

        VStack {
            if error {
                Text("An error has ocurred")
                Button("Retry") {
                    error.toggle()
                }
            } else {
                HStack(spacing: 0) {
                    AudioPlayer(toggleError: { newValue in toggleError(newValue: newValue) }, queue: socket.queue, queueRandomTrack: { viewModel.queueRandomTrack() })
                            .padding(.all)
                            .frame(minWidth: 400, maxWidth: 400)

                    Divider()
                    Spacer()
                    QueueList(toggleError: { newValue in toggleError(newValue: newValue) }, queue: $socket.queue, removeTrack: viewModel.removeTrack)
                            .padding(.all)
                            .frame(minWidth: 400)
                    Divider()
                    Spacer()
                    TracksList()
                            .padding(.all)
                            .frame(minWidth: 400)
                }
                        .padding(.all)

            }

        }
    }

    func toggleError(newValue: Bool?) {
        if let newValue = newValue {
            self.error = newValue
        } else {
            self.error = !self.error
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
