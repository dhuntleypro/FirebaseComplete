//
//  UserViewModel.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI

struct UserViewModel {
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    var confirmPassword: String = ""
    
    // MARK: - Validation Checks
    
    
    // Do the passwords Match ?
    func passwordsMatch(_confirmPW:String) -> Bool {
        return _confirmPW == password
    }
    
    // Is the field Empty ?
    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // Is this a valid Email address ?
    func isEmailValid(_email: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return passwordTest.evaluate(with: email)
    }
    
    // Does the password meet the minimum password requirments ?
    func isPasswordValid(_password: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    // Checks that all above checks are true and returning true if so and will be used to enable or disable the signup button (REGISTER)
    var isSignInComplete:Bool  {
        if  !isEmailValid(_email: email) ||
            isEmpty(_field: fullname) ||
            !isPasswordValid(_password: password) ||
            !passwordsMatch(_confirmPW: confirmPassword){
            return false
        }
        return true
    }
    
    // Disables the login button (LOGIN) if the fields are empty
    var isLogInComplete:Bool {
        if isEmpty(_field: email) ||
            isEmpty(_field: password) {
            return false
        }
        return true
    }
    
    // MARK: - Validation Error Strings (returning errors)
    
    
    var validNameText: String {
        if !isEmpty(_field: fullname) {
            return ""
        } else {
            return "Enter your full name"
        }
    }
    
    
    var validEmailAddressText:String {
        if isEmailValid(_email: email) {
            return ""
        } else {
            return "Enter a valid email address"
        }
    }
    
    var validPasswordText:String {
        if isPasswordValid(_password: password) {
            return ""
        } else {
            return "Must be 8 characters containing at least one number and one Capital letter."
        }
    }
    
    var validConfirmPasswordText: String {
        if passwordsMatch(_confirmPW: confirmPassword) {
            return ""
        } else {
            return "Password fields do not match."
        }
    }
}
