//
//  UserProductDetailsView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI

struct UserProductDetailsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UserProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserProductDetailsView()
    }
}


struct ProductDesignImageAndName : View {
    var userProduct : UserProduct

    var body: some View {
        VStack {
          //  Image("image")
            
            Rectangle()
                .frame(width: 100, height: 100)
            
            Text(userProduct.title)
                .bold()
            
        
        }
    }
}
