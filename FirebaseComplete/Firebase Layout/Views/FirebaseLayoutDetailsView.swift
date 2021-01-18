//
//  FirebaseLayoutDetailsView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI


struct FirebaseLayoutDetailsView: View {
    
    // fetch data / subscribe
    @StateObject var  firebaseLayoutVM = FirebaseLayoutsViewModel()
    @ObservedObject var  firebaseLayoutItemVM = FirebaseLayoutItemViewModel()
    
    // Call
    var firebaseLayout : FirebaseLayout
    var firebaseLayoutItem : FirebaseLayoutItem
    
    @State var presentAddNewProductSreen = false
    
    var body: some View {
        
        VStack {
            
            
            FirebaseLayoutDetailsMenuView(firebaseLayout: firebaseLayout)
            
            
            // Products List
//            FirebaseLayoutItemListViewWithPlus(presentAddNewProductSreen: $presentAddNewProductSreen, firebaseLayoutItem : firebaseLayoutItem)
//
            // Collections List
            Button(action: {
                firebaseLayoutItemVM.addADocument()
            }){
                Image(systemName: "command")
                    .font(.system(size: 66, weight: .regular))
            }
            .padding(50)
    
            Spacer()
        }
        .onAppear() {
            self.firebaseLayoutItemVM.subscribe()
            //   self.userProductVM.subscribe()
        }
    }
}

//struct FirebaseLayoutDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirebaseLayoutDetailsView()
//    }
//}


struct FirebaseLayoutDetailsMenuView : View {
    var firebaseLayout : FirebaseLayout
    
    
    var body: some View {
        HStack {
            
            Text("Hello, \(firebaseLayout.title)")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            Spacer()
            
//            NavigationLink(destination: FirebaseLayoutProfileView(firebaseLayout: firebaseLayout)) {
//                Image(systemName: "person")
//            }
//            .frame(width: 105, height: 105)
//            .foregroundColor(.black)
        }
        .padding()
        
    }
}



struct FirebaseLayoutItemListViewWithPlus : View {
    
    @Binding var presentAddNewProductSreen : Bool
    @ObservedObject var  firebaseLayoutItemVM = FirebaseLayoutItemViewModel()
    
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
                FirebaseLayoutItemAddView()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(firebaseLayoutItemVM.firebaseLayouts , id: \.id) { item in
                        NavigationLink(destination: FirebaseLayoutItemDetailsView()) {
                           // FirebaseLayoutItemDesignImageAndName(firebaseLayoutItem: item)
                            FirebaseLayoutItemDesignImageAndName()

                        }
                    }
                }
                .padding()
            }
        }
        .onAppear() {
            self.firebaseLayoutItemVM.subscribe()
        }
        
        
    }
}



