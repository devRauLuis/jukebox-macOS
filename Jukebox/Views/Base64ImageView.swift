//
//  Base64ImageView.swift
//  Jukebox
//
//  Created by Raúl Luis on 2/3/23.
//

import SwiftUI

struct Base64ImageView: View {
    var base64: String?
    var defaultImageIconSize: CGFloat = 50
    
    var body: some View {
        
        if let base64 = base64, let base64 = Data(base64Encoded: base64), let image = NSImage(data: base64) {
            Image(nsImage: image)
                .resizable()
                .scaledToFit()
        } else {
            IconImage(iconName: "music.note", fontSize: defaultImageIconSize, backgroundColor: .gray, foregroundColor: .white)
        }
    }
}

struct Base64ImageView_Previews: PreviewProvider {
    static var previews: some View {
        Base64ImageView(base64: nil)
    }
}
