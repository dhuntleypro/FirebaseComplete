//
//  FirebaseLayoutItemViewModel.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//


import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine


class FirebaseLayoutItemViewModel: ObservableObject{
    // hold collection called firebaseLayout and Instantiate and empty array
    @Published var firebaseLayouts = [FirebaseLayout]()
    
    @Published var firebaseLayout : FirebaseLayout
    
    // track if fields are modified / not empty
    @Published var modified = false
    
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(firebaseLayout: FirebaseLayout = FirebaseLayout(title: "", author: "", numberofPages: 0)) {
        self.firebaseLayout = firebaseLayout
        
        self.$firebaseLayout
            .dropFirst()
            .sink { [ weak self ] firebaseLayout in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    
    
    
    // Subscribe to any changes in FirebaseLayout
    func subscribe() {
        db
            .collection("firebaseLayouts")
            .addSnapshotListener { (querySnapshot, error) in
                // Checks if docmuent exist
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                //   self.firebaseLayouts = documents.compactMap { (queryDocumentSnapshot) -> FirebaseLayout? in
                self.firebaseLayouts = documents.compactMap { queryDocumentSnapshot in
                    
                    //  return
                    try? queryDocumentSnapshot.data(as: FirebaseLayout.self)
                    
                }
            }
    }
    
    
    
    // Add a new User Product to User
    func addFirebaseLayout(
        firebaseLayoutId : String ,
        firebaseLayout: FirebaseLayout
    ) {
       // let firebaseLayoutId = MYFBUser(from: UUID().uuidString)
        do {
            let _ = try
                db
                .collection("firebaseLayouts")
                .document(firebaseLayoutId)
                .collection("firebaseLayouts")
                .addDocument(from: firebaseLayout)
        }
        catch {
            print(error)
        }
    }
    
    
    
    
    
    // Save edits to firebase
    func save() {
        addFirebaseLayout(firebaseLayoutId: "", firebaseLayout: firebaseLayout)
    }
    
    
    func addADocument(
        // firebaseLayoutId : String ,
        // firebaseLayout: FirebaseLayout
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

