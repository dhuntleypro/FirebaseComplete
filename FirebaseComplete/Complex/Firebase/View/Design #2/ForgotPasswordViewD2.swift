//
//  fff.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//


import SwiftUI

// make sure to always change to project name
/*
 1. In firebase -
 1. firebase settings
 2. Project settings
 3. Public settings
 4. Edit Public facing-name to the app name
 */

struct ForgotPasswordViewD2: View {
    @State var user: UserViewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var errorString : String?
    
    var body: some View {
      
            VStack {
                TextField("Enter email address", text: $user.email).autocapitalization(.none).keyboardType(.emailAddress)
                Button(action: {
                    // Reset Password action
                    FBAuth.resetPassword(email: self.user.email) { (result) in
                        switch result {
                        case .failure(let error) :
                            self.errorString = error.localizedDescription
                        case .success(_) :
                            break
                        }
                        self.showAlert = true
                    }
                    
                }) {
                    Text("Reset")
                        .frame(width: 200)
                        .padding(.vertical, 15)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .opacity(user.isEmailValid(_email: user.email) ? 1 : 0.75)
                }
                .disabled(!user.isEmailValid(_email: user.email))
                Spacer()
            }.padding(.top)
            .frame(width: 300)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationBarTitle("Request a password reset", displayMode: .inline)
            .navigationBarItems(trailing: Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Reset"), message: Text(self.errorString ?? "Success. Reset email sent successfully.  Check your Email"), dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                    
                })
            }
        
    }
}


struct ForgotPasswordViewD2_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordViewD2()
    }
}
