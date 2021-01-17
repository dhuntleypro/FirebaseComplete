//
//  Book.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/16/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import Combine

// MARK: - MODEL (BOOK)

struct Book: Identifiable , Codable {
    // Read Document ID
    @DocumentID var id: String? = UUID().uuidString
    
    var title: String
    var author: String
    var numberofPages: Int
    
    //  Account for different names between firebase and model
    enum CodingKeys : String , CodingKey {
        case title
        case author
        case numberofPages = "pages"
    }
}


//
//let testData = [
//    Book(title: "yoo", author: "self", numberofPages: 5),
//    Book(title: "yeecoo", author: "seqcomoclf", numberofPages: 155),
//    Book(title: "yoscoppmso", author: "compsself", numberofPages: 55)
//
//
//
//]

// MARK: - VIEW MODEL -

class BooksViewModel: ObservableObject{
    // hold collection called book and Instantiate and empty array
    @Published var books = [Book]()
    
    
    
    private var db = Firestore.firestore()
    
    
    // Subscribe to any changes in Book
    func subscribe() {
        db
            .collection("books")
            .addSnapshotListener { (querySnapshot, error) in
                // Checks if docmuent exist
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                //   self.books = documents.compactMap { (queryDocumentSnapshot) -> Book? in
                self.books = documents.compactMap { queryDocumentSnapshot in
                    
                    //  return
                    try? queryDocumentSnapshot.data(as: Book.self)
                    
                }
            }
    }
}











class BookViewModel: ObservableObject{
    // hold collection called book and Instantiate and empty array
    @Published var book : Book
    
    // track if fields are modified / not empty
    @Published var modified = false
    
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(book: Book = Book(title: "", author: "", numberofPages: 0)) {
        self.book = book
        
        self.$book
            .dropFirst()
            .sink { [ weak self ] book in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    // Add a new Book
    func addBook(book: Book) {
        do {
            let _ = try  db
                .collection("books")
                .addDocument(from: book)
        }
        catch {
            print(error)
        }
    }
    
    // Save edits to firebase
    func save() {
        addBook(book: book)
    }
}



// MARK: - VIEW (BOOK)

struct BookListView: View {
    // var books = testData
    
    @ObservedObject private var viewModel = BooksViewModel()
    
    @State private var presentAddNewBookSreen = false
    var body: some View {
        List(viewModel.books) { book in
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
                Text("\(book.numberofPages) pages")
                    .font(.subheadline)
                
            }
        }
        .navigationTitle(Text("Books"))
        .sheet(isPresented: $presentAddNewBookSreen) {
            BookEditView()
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    presentAddNewBookSreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
        )
        .onAppear() {
            self.viewModel.subscribe()
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}


struct BookEditView : View {
    // When editing use @StateObject
    @StateObject var viewModel = BookViewModel()
    
    // dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Book")) {
                    TextField("Title", text: $viewModel.book.title)
                    
                    // value switch between int and string BUT HAVE TO HIT ENTER INORDER FOR IT TO UPDATE , SO use a  toggle instead
                    TextField("Pages", value: $viewModel.book.numberofPages , formatter: NumberFormatter())
                    
                }
                
                Section(header: Text("Book")) {
                    TextField("Author", text: $viewModel.book.author)
                }
                
                
            }
            .navigationBarTitle("New Book", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        handleCancelTapped()
                    }) {
                        Text("Cancel")
                    }
                ,trailing:
                    Button(action: {
                        handleDoneTapped()
                    }) {
                        Text("Done")
                    }.disabled(!viewModel.modified)
            )
        }
    }
    
    
    func handleCancelTapped() {
        dismiss()
    }
    

    func handleDoneTapped() {
        viewModel.save()
        dismiss()
    }
    
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
