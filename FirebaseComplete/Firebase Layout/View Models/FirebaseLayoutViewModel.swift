//
//  FirebaseLayoutView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//


import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine


class FirebaseLayoutsViewModel: ObservableObject{
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
    
    
    
    // Add a new FirebaseLayout
    func addFirebaseLayout(firebaseLayout: FirebaseLayout) {
        do {
            let _ = try  db
                .collection("firebaseLayouts")
                .addDocument(from: firebaseLayout)
        }
        catch {
            print(error)
        }
    }
    
    
    
    
    
    // Save edits to firebase
    func save() {
        addFirebaseLayout(firebaseLayout: firebaseLayout)
    }
}

