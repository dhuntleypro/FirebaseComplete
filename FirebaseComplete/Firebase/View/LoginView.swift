//
//  LoginView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI

struct LoginView: View {
    
 //   @EnvironmentObject var userInfo: UserInfo
//    enum Action {
//        case signUp, resetPW
//    }
    
  //  @State private var showSheetRegister = false
   // @State private var showSheetForgotPassword = false
 //   @State private var action : Action?
    
    var body: some View {
        VStack {
            SignInWithEmailView()
            
            SignInWithAppleView()
                .frame(width: 200, height: 50)
            
            Spacer()
        }
//        .sheet(isPresented: $showSheet) {
//            if self.action == .signUp {
//                SignUpView()
//            } else if self.action == .resetPW{
//                ForgotPasswordView()
//            } else {
//                Text("Error")
//            }
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
