//
//  FirebaseLayoutAddView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI


struct FirebaseLayoutAddView : View {
    // When editing use @StateObject
    @StateObject var  firebaseLayoutVM = FirebaseLayoutsViewModel()
    
    // dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("FIrebase")) {
                    TextField("Title", text: $firebaseLayoutVM.firebaseLayout.title)
                    
                    // value switch between int and string BUT HAVE TO HIT ENTER INORDER FOR IT TO UPDATE , SO use a  toggle instead
                    TextField("Pages", value: $firebaseLayoutVM.firebaseLayout.numberofPages , formatter: NumberFormatter())
                    
                }
                
                Section(header: Text("MYFBUser")) {
                    TextField("Author", text: $firebaseLayoutVM.firebaseLayout.author)
                }
                
                
            }
            .navigationBarTitle("New MYFBUser", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        handleCancelTapped()
                    }) {
                        Text("Cancel")
                    }
                ,trailing:
                    Button(action: {
                        handleDoneTapped()
                    }) {
                        Text("Done")
                    }.disabled(!firebaseLayoutVM.modified)
                
            )
        }
    }
    
    
    func handleCancelTapped() {
        dismiss()
    }
    

    func handleDoneTapped() {
        firebaseLayoutVM.save()
        dismiss()
    }
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
