//
//  FirebaseLayout.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI
import FirebaseFirestoreSwift


struct FirebaseLayout: Identifiable , Codable {
    // Read Document ID
    @DocumentID var id: String? = UUID().uuidString
    
    
    var title: String
    var author: String
    var numberofPages: Int
    
    //  Account for different names between firebase and model
    enum CodingKeys : String , CodingKey {
        case title
        case author
        case numberofPages = "pages"
    }
}


