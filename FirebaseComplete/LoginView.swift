//
//  LoginView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        Button(action: {
            self.userInfo.isUserAuthenticated = .signedIn
        }) {
            Text("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
