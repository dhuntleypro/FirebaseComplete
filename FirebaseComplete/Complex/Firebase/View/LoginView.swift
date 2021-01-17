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
//        // Design #1
//        VStack {
//
//            SignInWithEmailView()
//
//            SignInWithAppleView()
//                .frame(width: 200, height: 50)
//
//            Spacer()
//        }
        
        
        // Design #2
        VStack {
            SignInWithEmailViewD2()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
