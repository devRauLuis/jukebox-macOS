//
//  IconImage.swift
//  Jukebox
//
//  Created by Raúl Luis on 3/3/23.
//

import SwiftUI

struct IconImage: View {
    let iconName: String
    let fontSize: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        ZStack {
            backgroundColor
            Image(systemName: iconName)
                .font(.system(size: fontSize))
                .foregroundColor(foregroundColor)
                .minimumScaleFactor(0.5)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct IconImage_Previews: PreviewProvider {
    static var previews: some View {
        IconImage(iconName: "music.note", fontSize: 100, backgroundColor: .gray, foregroundColor: .white)
    }
}
