//
//  ContentView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI

struct ContentView: View {
    // keep track of user state across app and show 1 of 3 views
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading..")
            } else if userInfo.isUserAuthenticated == .signedOut {
               LoginView()
            } else {
                HomeView()
            }
        }
        .onAppear() {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
