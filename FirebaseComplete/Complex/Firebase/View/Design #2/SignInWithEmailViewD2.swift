//
//  SignInWithEmailViewD2.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI


struct SignInWithEmailViewD2: View {
    
    // Used
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel()

    
    @State var showForgotPassword = false
    
    // Errors
    @State private var showAlert = false
    @State private var authError : EmailAuthError?
    
    @State var signup = false

    
 //   @State var alert = false
 //   @State var error = ""
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showError = false
    @State private var errorString = ""
    
    var body: some View {
        VStack{
            Group {
                Spacer(minLength: 0)
                
                Image("loginLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //Dynamic Frame...
                    .padding(.horizontal,35)
                    .padding(.vertical)
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text(signup ? "Register" : "Login" )
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(signup ?  "Please fill in fields below" : "Please sign in to continue" )
                            .foregroundColor(Color.white.opacity(0.5))
                    })
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading,15)
            }
            Group {
                if signup {
                    
                    // FULL NAME
                    HStack {
                        Image(systemName: "person")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        
                        TextField("FULL NAME", text: self.$user.fullname).autocapitalization(.words)
                        
                    }
                    .padding()
                    .background(Color.white.opacity(user.fullname == "" ? 0 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                 
                        if !user.validNameText.isEmpty {
                            Text(user.validNameText).font(.caption).foregroundColor(.red)
                        }
                      
                    
                }
                // EMAIL
                HStack{
                    
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("EMAIL", text: self.$user.email)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(user.email == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                    if signup {
                        if !user.validEmailAddressText.isEmpty {
                            Text(user.validEmailAddressText).font(.caption).foregroundColor(.red)
                        }
                    
                  
                }
            }
            Group {
                // PASSWORD
                HStack{
                    
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    SecureField("PASSWORD", text: $user.password)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(user.password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
               
                    if signup {
                        if !user.validPasswordText.isEmpty {
                            Text(user.validPasswordText).font(.caption).foregroundColor(.red)
                                .frame(width: 300)
                        }
                    
                }
                // RE-ENTER PASSWORD
                if signup {
                    HStack{
                        
                        Image(systemName: "lock")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        
                        SecureField("RE-ENTER PASSWORD", text: $user.confirmPassword)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color.white.opacity(user.confirmPassword == "" ? 0 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    if !user.passwordsMatch(_confirmPW: user.confirmPassword) {
                        Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
                    }
                }
            }
            
            HStack(spacing: 15){
                
                Button(action: {
                    if signup {
                        //  Sign Up Action
                        FBAuth.createUser(withEmail: self.user.email,
                                          name: self.user.fullname,
                                          password: self.user.password
                                          
                        ) { (result) in
                            switch result {
                            case .failure(let error) :
                                self.errorString = error.localizedDescription
                                
                                self.showError = true
                            case .success(_):
                                print("Account creation successful")
                            }
                        }
                        
                    } else {
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
                        
                    }
                    
                }, label: {
                    Text(signup ?  "REGISTER" : "LOGIN")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("teal"))
                        .clipShape(Capsule())
                })
                .opacity(user.email != "" && user.confirmPassword != "" ? 1 : 0.5)
                .disabled(user.email != "" && user.confirmPassword != "" ? false : true)
                //                .disabled(signup ? !user.isSignInComplete : )
                
                
                //                if getBioMetricStatus(){
                //
                //                    Button(action: authenticateUser, label: {
                //
                //                        // getting biometrictype...
                //                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                //                            .font(.title)
                //                            .foregroundColor(.black)
                //                            .padding()
                //                            .background(Color("teal"))
                //                            .clipShape(Circle())
                //                    })
                //                }
            }
            .padding(.top)
            
            // Forget Button...
            
            Button(action: {
                showForgotPassword.toggle()
            }, label: {
                Text(signup ?  "" : "Forget password?" )
                    .foregroundColor(Color("teal"))
            })
            .padding(.top,8)
            .sheet(isPresented: $showForgotPassword) {
                ForgotPasswordViewD2()
            }
            
            // SignUp...
            
            Spacer(minLength: 0)
            
            HStack(spacing: 5){
                
                Text(signup ?   "Already have an account!" : "Don't have an account? ")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: {
                    signup.toggle()
                    
                }, label: {
                    Text(signup ? "Signin"  : "Signup" )
                        .fontWeight(.heavy)
                        .foregroundColor(Color("teal"))
                })
            }
            .padding(.vertical)
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .alert(isPresented: $showError) {
            Alert(title: Text("Error creating Account"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignInWithEmailViewD2_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithEmailViewD2()
    }
}
