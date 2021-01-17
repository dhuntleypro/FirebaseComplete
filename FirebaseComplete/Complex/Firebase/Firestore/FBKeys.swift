//
//  FBKeys.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/14/21.
//

import SwiftUI
import Foundation

enum FBKeys {
    
    enum CollectionPath {
        static let users = "users"
    }
    
    enum User {
        static let uid = "uid"
        static let name = "name"
        static let email = "email"
        
        // Add app specific keys here
        static let storeName = "storeName"
    }
}
