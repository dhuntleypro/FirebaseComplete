//
//  MYFBUserDetailsView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI

struct MYFBUserDetailsView: View {
    
    // fetch data / subscribe
    @StateObject var  myFBUserVM = MYFBUsersViewModel()
    @ObservedObject var  userProductVM = UserProductViewModel()
    
    // Call
    var myFBUser : MYFBUser
    var userProduct : UserProduct
    
    @State var presentAddNewProductSreen = false
    
    var body: some View {
        
        VStack {
            
            
            MYFBUserDetailsMenuView(myFBUser: myFBUser)
            
            
            // Products List
            ProductListViewWithPlus(presentAddNewProductSreen: $presentAddNewProductSreen, userProductVM : userProductVM)
            
            // Collections List
            
            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear() {
            self.myFBUserVM.subscribe()
            //   self.userProductVM.subscribe()
        }
    }
}

//struct MYFBUserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MYFBUserDetailsView()
//    }
//}


struct MYFBUserDetailsMenuView : View {
    var myFBUser : MYFBUser
    
    
    var body: some View {
        HStack {
            
            Text("Hello, \(myFBUser.title)")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Spacer()
            NavigationLink(destination: ProfileView(myFBUser: myFBUser)) {
                Image(systemName: "person")
            }
            .frame(width: 105, height: 105)
            .foregroundColor(.black)
        }
        .padding()
        
    }
}



struct ProductListViewWithPlus : View {
    
    @Binding var presentAddNewProductSreen : Bool
    @ObservedObject var  userProductVM = UserProductViewModel()
    
    var body: some View {
        // Products
        VStack {
            HStack {
                
                Text("Products")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
                Spacer()
                
                Button(action: {
                    presentAddNewProductSreen.toggle()
                    
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            .sheet(isPresented: $presentAddNewProductSreen) {
                UserProductAddView()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(userProductVM.userProducts , id: \.id) { product in
                        NavigationLink(destination: UserProductDetailsView()) {
                            ProductDesignImageAndName(userProduct: product)
                            
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear() {
            self.userProductVM.subscribe()
        }
        
        
    }
}



