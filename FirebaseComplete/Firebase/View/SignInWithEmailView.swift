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
    
    @State private var showAlert = false
    @State private var authError : EmailAuthError?
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
                    FBAuth.authenticate(withEmail: self.user.email,
                                        password: self.user.password) { (result) in
                        switch result {
                        case .failure(let error):
                            self.authError = error
                            self.showAlert = true
                        case .success(_) :
                            print("Signed In")
                        }
                    }
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unknown Error"), dismissButton: .default(Text("OK")) {
                    if self.authError == .incorrectPassword {
                        self.user.password = ""
                    } else {
                        self.user.password = ""
                        self.user.email = ""
                    }
                })
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
