//
//  FirebaseCompleteApp.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI
import Firebase

@main
struct FirebaseCompleteApp: App {
    
    var userInfo = UserInfo()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userInfo)
        }
    }
}
