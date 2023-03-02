//
//  ProgressBar.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import SwiftUI

struct ProgressBar: View {
    var currentTime: String
    var totalTime: String
    var progress: Float
    
    
    var body: some View {
        HStack{
            Text(currentTime)
            ProgressView(value: progress )
            Text(totalTime)
        }.padding([.leading, .trailing])
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(currentTime:"00:01", totalTime: "02:35", progress: 0.01)
    }
}
