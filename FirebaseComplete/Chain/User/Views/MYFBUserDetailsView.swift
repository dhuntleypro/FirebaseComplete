//
//  MYFBUserDetailsView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI

struct MYFBUserDetailsView: View {
    
    // fetch data / subcribe
    @StateObject var  myFBUserVM = MYFBUsersViewModel()
    @ObservedObject var  userProductVM = UserProductViewModel()
    
    // Call
    var myFBUser : MYFBUser
    var userProduct : UserProduct
    
    
    var body: some View {
        VStack {
            VStack {
                Text("User Information")
                Text(myFBUser.title)
                
                Text(myFBUser.author)
                
                Text(myFBUser.id ?? "")
            }
            ScrollView(.horizontal) {
                ForEach(userProductVM.userProducts , id: \.id) { product in
                    
                    VStack {
                        Text(product.title)
                        
                      //  Text(product.author)
                    }
                }
            }
            
        }
        .onAppear() {
            self.myFBUserVM.subscribe()
            self.userProductVM.subscribe()
        }
    }
}

//struct MYFBUserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MYFBUserDetailsView()
//    }
//}
