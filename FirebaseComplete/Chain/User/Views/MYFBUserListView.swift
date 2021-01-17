//
//  MyUserUsersView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine



struct MYFBUserListView: View {
    
    @ObservedObject private var myFBUserVM = MYFBUsersViewModel()

    var userProduct : UserProduct
    @State private var presentAddNewMYFBUserSreen = false
    
    
    var body: some View {
        List {
            ForEach(myFBUserVM.myFBUsers, id: \.id) { myFBUser in
                NavigationLink(destination:
                                MYFBUserDetailsView(
                                    myFBUser: myFBUser,
                                    userProduct: userProduct
                                       // UserProduct(
//
//                                        title: <#T##String#>,
//                                        author: <#T##String#>,
//                                        numberofPages: <#T##Int#>)
                                
                                
                                
                               ) ) {
                        
                    UserListCell(myFBUser: myFBUser)
                    
                }
            }
        }
        .navigationTitle(Text("MYFBUsers"))
        .sheet(isPresented: $presentAddNewMYFBUserSreen) {
            MYFBUserAddView()
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    presentAddNewMYFBUserSreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
        )
        .onAppear() {
            self.myFBUserVM.subscribe()
        }
    }
}

//struct MYFBUserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MYFBUserListView(userProduct: <#UserProduct#>)
//    }
//}


struct UserListCell : View {
    var myFBUser : MYFBUser

    var body: some View {
        VStack(alignment: .leading) {
            Text(myFBUser.title)
                .font(.headline)
            Text(myFBUser.author)
                .font(.subheadline)
            Text("\(myFBUser.numberofPages) pages")
                .font(.subheadline)
            
        }
    }
}
