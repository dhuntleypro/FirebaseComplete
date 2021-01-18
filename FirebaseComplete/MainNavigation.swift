//
//  MainNavigation.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/16/21.
//

import SwiftUI

struct MainNavigation: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SimpleNoFirebasePulls()) {
                    Text("Simple")
                }
                // Complex
                NavigationLink(destination: AppNavigationView()) {
                    Text("Complex")
                }
                
                NavigationLink(destination: BookListView()) {
                    Text("BookListView")
                }
                
                NavigationLink(destination: MYFBUserListView(userProduct: UserProduct( title: "", author: "", numberofPages: 0))) {
                    Text("My User Users View")
                }
                
                NavigationLink(destination: QuickCommandView()) {
                    Text("BookListView")
                }
                
                NavigationLink(destination: CollectionStart()) {
                    Text("Firebase Layout View")
                }
                
                
                
                
            }
            .navigationTitle(Text("Firebase"))
        }
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}
