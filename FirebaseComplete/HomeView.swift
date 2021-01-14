//
//  HomeView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Logged in as \(userInfo.user.name)")
                
              //  TextField("name" ,text: $userInfo.name )
            }
            .navigationBarTitle("Firebase Login")
            .navigationBarItems(trailing: Button("Log out") {
               // self.userInfo.isUserAuthenticated = .signedOut
                FBAuth.logout { (result) in
                    print("Logged Out")
                }
            })
        }
        .onAppear() {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            FBFirestore.retrieveFBUser(uid: uid) { (result) in
                switch result {
                case .failure(let error) :
                    print(error.localizedDescription)
                    // dis play some kind of alart to your user (It shouldn't happen)
                case .success(let user) :
                    self.userInfo.user = user
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
