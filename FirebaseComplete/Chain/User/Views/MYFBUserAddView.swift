//
//  MYFBUserAddView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI


struct MYFBUserAddView : View {
    // When editing use @StateObject
    @StateObject var  myFBUserVM = MYFBUsersViewModel()
    
    // dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("MYFBUser")) {
                    TextField("Title", text: $myFBUserVM.myFBUser.title)
                    
                    // value switch between int and string BUT HAVE TO HIT ENTER INORDER FOR IT TO UPDATE , SO use a  toggle instead
                    TextField("Pages", value: $myFBUserVM.myFBUser.numberofPages , formatter: NumberFormatter())
                    
                }
                
                Section(header: Text("MYFBUser")) {
                    TextField("Author", text: $myFBUserVM.myFBUser.author)
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
                    }.disabled(!myFBUserVM.modified)
            )
        }
    }
    
    
    func handleCancelTapped() {
        dismiss()
    }
    

    func handleDoneTapped() {
        myFBUserVM.save()
        dismiss()
    }
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
