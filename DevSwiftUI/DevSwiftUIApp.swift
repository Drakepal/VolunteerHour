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
     
@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
   
     
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            SplashScreen()
                .environmentObject(viewModel)
        }
    }
}


class AppDelegate: NSObject,  UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
