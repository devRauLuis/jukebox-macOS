//
//  ContentView.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    var body: some View {
        HStack(spacing: 0) {
            AudioPlayer(songId: "01")
            Spacer()
            Text("Item 2")
            Spacer()
            Text("Item 3")
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .edgesIgnoringSafeArea(.all)
//          
   
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
