//
//  HomeView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Logined in as User")
            }
            .navigationBarTitle("Firebase Login")
            .navigationBarItems(trailing: Button("Log out") {
                self.userInfo.isUserAuthenticated = .signedOut
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
