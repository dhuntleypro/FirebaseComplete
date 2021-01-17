//
//  kkk.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine



struct UserProductListView: View {
    
    @ObservedObject private var viewModel = UserProductViewModel()
    
    @State private var presentAddNewUserProductSreen = false
    
    
    var body: some View {
        List {
            ForEach(viewModel.userProducts) { userProduct in
                NavigationLink(destination: UserProductDetailsView()) {
                        
                    UserProductListCell(userProduct: userProduct)
                    
                }
            }
        }
        .navigationTitle(Text("UserProducts"))
        .sheet(isPresented: $presentAddNewUserProductSreen) {
            UserProductAddView()
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    presentAddNewUserProductSreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
        )
        .onAppear() {
            self.viewModel.subscribe()
        }
    }
}

struct UserProductListView_Previews: PreviewProvider {
    static var previews: some View {
        UserProductListView()
    }
}


struct UserProductListCell : View {
    
    var userProduct : UserProduct

    var body: some View {
        VStack(alignment: .leading) {
            Text(userProduct.title)
                .font(.headline)
            Text(userProduct.author)
                .font(.subheadline)
            Text("\(userProduct.numberofPages) pages")
                .font(.subheadline)
            
        }
    }
}

