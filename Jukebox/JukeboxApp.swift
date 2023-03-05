//
//  JukeboxApp.swift
//  Jukebox
//
//  Created by Raúl Luis on 1/3/23.
//

import SwiftUI

@main
struct JukeboxApp: App {
    
    init() {
        setenv("CFNETWORK_DIAGNOSTICS", "3", 1)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
   
}
