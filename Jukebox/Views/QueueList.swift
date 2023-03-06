//
//  QueueList.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import SwiftUI

struct QueueList: View {

    var toggleError: (Bool?) -> Void
    @Binding var queue: [Track]?
    var removeTrack: (String) -> Void

    var body: some View {
        if let queue = queue, queue.count < 2 {
            VStack(alignment: .center) {
                Text("No tracks in queue.")
            }
        } else {
            VStack {
                if let queue = queue, let queue = queue.dropFirst() {
                    List(queue) { track in
                        QueueRow(track: track, handleDelete: { removeTrack(track.posId ?? "") })
                    }
                }
            }
        }
    }
}


struct QueueList_Previews: PreviewProvider {
    static var previews: some View {
        QueueList(toggleError: { newVal in }, queue: .constant([Track]()), removeTrack: { track in })
    }
}
