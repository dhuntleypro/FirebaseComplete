//
//  vvvv.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine


class MYFBUsersViewModel: ObservableObject{
    // hold collection called myFBUser and Instantiate and empty array
    @Published var myFBUsers = [MYFBUser]()
    
    @Published var myFBUser : MYFBUser
    
    // track if fields are modified / not empty
    @Published var modified = false
    
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(myFBUser: MYFBUser = MYFBUser(title: "", author: "", numberofPages: 0)) {
        self.myFBUser = myFBUser
        
        self.$myFBUser
            .dropFirst()
            .sink { [ weak self ] myFBUser in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    
    
    
    // Subscribe to any changes in MYFBUser
    func subscribe() {
        db
            .collection("myFBUsers")
            .addSnapshotListener { (querySnapshot, error) in
                // Checks if docmuent exist
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                //   self.myFBUsers = documents.compactMap { (queryDocumentSnapshot) -> MYFBUser? in
                self.myFBUsers = documents.compactMap { queryDocumentSnapshot in
                    
                    //  return
                    try? queryDocumentSnapshot.data(as: MYFBUser.self)
                    
                }
            }
    }
    
    
    
    // Add a new MYFBUser
    func addMYFBUser(myFBUser: MYFBUser) {
        do {
            let _ = try  db
                .collection("myFBUsers")
                .addDocument(from: myFBUser)
        }
        catch {
            print(error)
        }
    }
    
    
    
    
    
    // Save edits to firebase
    func save() {
        addMYFBUser(myFBUser: myFBUser)
    }
}

