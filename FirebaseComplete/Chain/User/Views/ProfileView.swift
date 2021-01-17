//
//  ProfileView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI

struct ProfileView: View {
    var myFBUser : MYFBUser
    
    
    var body: some View {
        VStack {
            HStack{
            Text("Author : \(myFBUser.author)")
                .bold()
                Spacer()
            }
            HStack {
            Text(myFBUser.id ?? "")
                .bold()
                Spacer()
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(myFBUser: <#MYFBUser#>)
//    }
//}
