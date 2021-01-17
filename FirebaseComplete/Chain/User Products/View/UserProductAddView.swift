//
//  UserProductAddView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI

struct UserProductAddView : View {
    // When editing use @StateObject
    @StateObject var  userProductViewModel = UserProductViewModel()
    
    // dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("UserProduct")) {
                    TextField("Title", text: $userProductViewModel.userProduct.title)
                    
                    // value switch between int and string BUT HAVE TO HIT ENTER INORDER FOR IT TO UPDATE , SO use a  toggle instead
                    TextField("Pages", value: $userProductViewModel.userProduct.numberofPages , formatter: NumberFormatter())
                    
                }
                
                Section(header: Text("UserProduct")) {
                    TextField("Author", text: $userProductViewModel.userProduct.author)
                }
                
                
            }
            .navigationBarTitle("New UserProduct", displayMode: .inline)
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
                    }.disabled(!userProductViewModel.modified)
            )
        }
    }
    
    
    func handleCancelTapped() {
        dismiss()
    }
    

    func handleDoneTapped() {
        userProductViewModel.save()
        dismiss()
    }
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
