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
