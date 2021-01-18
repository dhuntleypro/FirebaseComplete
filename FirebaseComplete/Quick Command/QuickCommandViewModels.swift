//
//  QuickCommandViewModels.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

class QuickCommandViewModel: ObservableObject{
    // hold collection called quickCommand and Instantiate and empty array
    @Published var quickCommands = [QuickCommand]()
    
    @Published var quickCommand : QuickCommand
    
    // track if fields are modified / not empty
    @Published var modified = false
    
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(quickCommand: QuickCommand = QuickCommand(
            name: "",
            image: "",
            title: "",
            author: "",
            numberofPages: 0)) {
        self.quickCommand = quickCommand
        
        self.$quickCommand
            .dropFirst()
            .sink { [ weak self ] quickCommand in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    
    
    //ADD DOCUMENT
    func addADocument() {
        
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = db
            .collection("test")
            .addDocument(data: [
                
            "name": "String",
            "image": "String",
            "title": "String",
            "author": "String",
            "numberofPages": 0
                
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
    }
    

    //ADD DOCUMENT 2
    func addADocument2() {
        
        /// To update age and favorite color:
        db.collection("test")
            .addDocument(data: [
                        "name": "Tokyo",
                        "title": "Japan"
                            ]
            )
            .updateData([
                "name": "ddddddddddddd",
                "title": "Red"
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        
        
    }
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Subscribe to any changes in QuickCommand
    func subscribe() {
        db
            .collection("quickCommands")
            .addSnapshotListener { (querySnapshot, error) in
                // Checks if docmuent exist
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                //   self.quickCommands = documents.compactMap { (queryDocumentSnapshot) -> QuickCommand? in
                self.quickCommands = documents.compactMap { queryDocumentSnapshot in
                    
                    //  return
                    try? queryDocumentSnapshot.data(as: QuickCommand.self)
                    
                }
            }
    }
    
    
    
    // Add a new User Product to User
    func addQuickCommand(quickCommand: QuickCommand
    ) {
       // let userId = MYFBUser(from: UUID().uuidString)
        do {
            let _ = try
                db
              
                .collection("test")
                .addDocument(from: quickCommand)
        }
        catch {
            print(error)
        }
    }
    
    
    
    
    
    // Save edits to firebase
    func save() {
        addQuickCommand(quickCommand: quickCommand )
    }
    
    

}

