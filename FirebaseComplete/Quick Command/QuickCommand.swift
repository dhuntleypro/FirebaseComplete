//
//  QuickCommand.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI
import FirebaseFirestoreSwift


struct QuickCommand: Identifiable , Codable {
    // Read Document ID
    @DocumentID var id: String? = UUID().uuidString
    
    var name: String
    var image: String
    var title: String
    var author: String
    var numberofPages: Int
    
    //  Account for different names between firebase and model
    enum CodingKeys : String , CodingKey {
        
        case name
        case image
        case title
        case author
        case numberofPages = "pages"
    }
}


