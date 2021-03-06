//
//  UserProductViewModel.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine


class UserProductViewModel: ObservableObject{
    // hold collection called userProduct and Instantiate and empty array
    @Published var userProducts = [UserProduct]()
    
    @Published var userProduct : UserProduct
    
    // track if fields are modified / not empty
    @Published var modified = false
    
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(userProduct: UserProduct = UserProduct(title: "", author: "", numberofPages: 0)) {
        self.userProduct = userProduct
        
        self.$userProduct
            .dropFirst()
            .sink { [ weak self ] userProduct in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    
    
    
    // Subscribe to any changes in UserProduct
    func subscribe() {
        db
            .collection("userProducts")
            .addSnapshotListener { (querySnapshot, error) in
                // Checks if docmuent exist
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                //   self.userProducts = documents.compactMap { (queryDocumentSnapshot) -> UserProduct? in
                self.userProducts = documents.compactMap { queryDocumentSnapshot in
                    
                    //  return
                    try? queryDocumentSnapshot.data(as: UserProduct.self)
                    
                }
            }
    }
    
    
    
    // Add a new User Product to User
    func addUserProduct(
        userId : String ,
        userProduct: UserProduct
    ) {
       // let userId = MYFBUser(from: UUID().uuidString)
        do {
            let _ = try
                db
                .collection("users")
                .document(userId)
                .collection("userProducts")
                .addDocument(from: userProduct)
        }
        catch {
            print(error)
        }
    }
    
    
    
    
    
    // Save edits to firebase
    func save() {
        addUserProduct(userId: "", userProduct: userProduct)
    }
    
    
    func addADocument(
        // userId : String ,
        // userProduct: UserProduct
    ) {
        
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = db
            .collection("test")
            .addDocument(data: [
                "name": "Tokyo",
                "country": "Japan"
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
    }
    


}

