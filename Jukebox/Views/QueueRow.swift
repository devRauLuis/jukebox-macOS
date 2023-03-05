//
//  QueueRow.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import SwiftUI

struct QueueRow: View {
    var track: Track
    var handleDelete: () -> Void
    
    var body: some View {
        HStack{
            Base64ImageView(base64: track.image, defaultImageIconSize: 30 ).frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text(track.title)
                    .font(.system(size: 16))
                    .bold()
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(track.artist).font(.subheadline)
            }
            Spacer()
            Button(action: handleDelete){
                Image(systemName: "trash.fill").foregroundColor(.red).font(.system(size: 12))
            }.buttonStyle(.plain)
        }.padding([.top, .bottom]).onAppear {
            print("track image \(track.image)")
        }
    }
}

struct QueueRow_Previews: PreviewProvider {
    static var previews: some View {
        QueueRow(track:  Track(songName: "01",
                               title: "Days Before Rodeo The Prequel",
                               trackNumber: "1",
                               genre: "",
                               artist: "Travis Scott",
                               releaseTime: "Travi$ Scott",
                               year: "Travi$ Scott",
                               album: "Days Before Rodeo",
                               image: "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAIAAADTED8xAAADMElEQVR4nOzVwQnAIBQFQYXff81RUkQCOyDj1YOPnbXWPmeTRef+/3O/OyBjzh3CD95BfqICMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMO0TAAD//2Anhf4QtqobAAAAAElFTkSuQmCC", posId: "abcdefghijk"), handleDelete: {})
    }
}
