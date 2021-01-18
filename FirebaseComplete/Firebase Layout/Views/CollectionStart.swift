//
//  CollectionStart.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI

struct CollectionStart: View {
    var body: some View {
        VStack {
            NavigationLink(destination: FirebaseLayoutListView(firebaseLayoutItem: FirebaseLayoutItem(title: "", author: "", numberofPages: 0))
            ) {
                VStack {
                    Text("Collection #1")
                        .foregroundColor(.black)

                    Text("TEST")
                        .bold()
                        .foregroundColor(.green)

                       
                }
                .font(.system(size: 20))
                
            }
            
        }
        .navigationBarHidden(true)


    }
}

struct CollectionStart_Previews: PreviewProvider {
    static var previews: some View {
        CollectionStart()
    }
}
