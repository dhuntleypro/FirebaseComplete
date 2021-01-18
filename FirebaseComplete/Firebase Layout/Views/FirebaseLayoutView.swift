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



struct FirebaseLayoutListView: View {
    
    @ObservedObject private var firebaseLayoutVM = FirebaseLayoutsViewModel()
    
    var firebaseLayoutItem : FirebaseLayoutItem
    @State private var presentAddNewFirebaseLayoutScreen = false
    
    
    var body: some View {
        
        
        
        
        HStack {
            Text("Collection #2")
                .font(.system(size: 30 , weight: .bold, design: .rounded) )
            
            Spacer()
            
            Button(action: {
                presentAddNewFirebaseLayoutScreen.toggle()
            }) {
                Image(systemName: "plus")
            }
            
        }
        .padding()
        
        List {
            ForEach(firebaseLayoutVM.firebaseLayouts, id: \.id) { firebaseLayout in
                NavigationLink(destination:
                                FirebaseLayoutDetailsView(
                                    firebaseLayout: firebaseLayout,
                                    firebaseLayoutItem: firebaseLayoutItem
                                    // FirebaseLayoutItem(
                                    //
                                    //                                        title: <#T##String#>,
                                    //                                        author: <#T##String#>,
                                    //                                        numberofPages: <#T##Int#>)
                                    
                                    
                                    
                                ) ) {
                    
                    FirebaseLayoutListCell(firebaseLayout: firebaseLayout)
                    
                }
            }
        }
        
        
        .sheet(isPresented: $presentAddNewFirebaseLayoutScreen) {
            FirebaseLayoutAddView()
        }
        .navigationBarItems(
            
            trailing:
                
                
                NavigationLink(destination: Collection3()) {
                    Text("See Collection #3")
                }
            
        )
        .onAppear() {
            self.firebaseLayoutVM.subscribe()
        }
    }
}

//struct FirebaseLayoutListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirebaseLayoutListView(userProduct: FirebaseLayoutItem)
//    }
//}


struct FirebaseLayoutListCell : View {
    var firebaseLayout : FirebaseLayout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(firebaseLayout.title)
                    .font(.headline)
                Text(firebaseLayout.author)
                    .font(.subheadline)
                Text("\(firebaseLayout.numberofPages) pages")
                    .font(.subheadline)
                
            }
            
            Spacer()
            
            Text("See Document")
                .bold()
        }
    }
}
