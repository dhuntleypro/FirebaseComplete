//
//  SignInWithEmailView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI


struct SignInWithEmailView: View {
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel()
 //   @Binding var showSheet: Bool
 //   @Binding var action:LoginView.Action?
    
    @State var showRegisterSheet = false
    @State var showForgotPassword = false
    
    var body: some View {
        VStack {
            TextField("Email Address",
                      text: self.$user.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $user.password)
            HStack {
                Spacer()
                Button(action: {
                 //   self.action = .resetPW
               //     self.showSheet = true
                    showForgotPassword.toggle()
                }) {
                    Text("Forgot Password")
                }
                .sheet(isPresented: $showForgotPassword) {
                    ForgotPasswordView()
                }
            }.padding(.bottom)
            VStack(spacing: 10) {
                Button(action: {
                    // Sign In Action
                }) {
                    Text("Login")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .opacity(user.isLogInComplete ? 1 : 0.75)
                }
                .disabled(!user.isLogInComplete)
                
                
                Button(action: {
                 //   self.action = .signUp
                 //   self.showSheet = true
                    showRegisterSheet.toggle()
                }) {
                    Text("Sign Up")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $showRegisterSheet) {
                    SignUpView()
                }

            }
        }
        .padding(.top, 100)
        .frame(width: 300)
        .textFieldStyle(RoundedBorderTextFieldStyle())
//        .onAppear() {
//            self.action = .signUp
//            print("Action Status: \(String(describing: action))")
//
//        }
//
    }
}

struct SignInWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithEmailView()
    }
}
