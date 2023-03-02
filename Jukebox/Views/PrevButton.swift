//
//  PrevButton.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import SwiftUI

struct PrevButton: View {
    var handleClick: () -> Void
    
    var body: some View {
        Button(action: handleClick) {
            Label("Previous Track", systemImage: "backward.fill")
                .labelStyle(.iconOnly)
                .foregroundColor(.gray)
                .font(.system(size: 32.0))
        }
        .buttonStyle(.plain)
    }
}

struct PrevButton_Previews: PreviewProvider {
    static var previews: some View {
        PrevButton(handleClick: { })
    }
}
