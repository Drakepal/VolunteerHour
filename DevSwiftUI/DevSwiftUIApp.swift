//
//  DevSwiftUIApp.swift
//  DevSwiftUI
//
//  Created by PM Student on 11/16/22.
//

import SwiftUI
import Firebase
 
@main
struct DevSwiftUIApp: App {
     
    init() {
    FirebaseApp.configure()
    }
     
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
