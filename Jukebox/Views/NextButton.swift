//
//  NextButton.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import SwiftUI

struct NextButton: View {
    var handleClick: () -> Void

    var body: some View {
        Button(action: handleClick) {
            Label("Next Track", systemImage: "forward.fill")
                .labelStyle(.iconOnly)
                .foregroundColor(.gray)
                .font(.system(size: 32.0))
        }
        .buttonStyle(.plain)
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(handleClick: {})
    }
}
