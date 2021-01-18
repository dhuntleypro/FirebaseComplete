//
//  QuickCommandView.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/17/21.
//

import SwiftUI

struct QuickCommandView: View {
    @ObservedObject private var quickCommandVM = QuickCommandViewModel()
    
    @State var addDocumentAlert = false
    var body: some View {
        VStack {
            
            
            HStack {
                Text("Collection Level 1")
                    .bold()
                
                Spacer()
                
                Button(action: {
                  //  quickCommandVM.addADocument()
                    quickCommandVM.addQuickCommand(quickCommand: quickCommandVM.quickCommand)
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            
            ForEach(quickCommandVM.quickCommands , id : \.id) { qq in
                Text(qq.name)
                Divider()
                
            }
            
            
            
            
            
            
            
            Button(action: {
                
                // Add a Document
              //  quickCommandVM.addADocument()
                
                // ??
                quickCommandVM.addADocument2()
                
                
                addDocumentAlert.toggle()
            }) {
                HStack {
                    
                    Image(systemName: "ant.circle").font(.system(size: 16, weight: .regular))
                    Text("Add Document")
                }
            }
            .padding()
            .alert(isPresented: $addDocumentAlert) {
                Alert(title: Text("Document added to Test"), message: Text("Check Firebase to Confirm"), dismissButton: .default(Text("OK")))
            }
            
            
            
            
            
            
            Spacer()
        }
        .onAppear() {
            self.quickCommandVM.subscribe()

        }
    }
}

struct QuickCommandView_Previews: PreviewProvider {
    static var previews: some View {
        QuickCommandView()
    }
}
