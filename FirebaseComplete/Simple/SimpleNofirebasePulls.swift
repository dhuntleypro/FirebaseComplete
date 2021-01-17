//
//  SimpleNofirebasePulls.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/16/21.
//

import SwiftUI

struct SimpleNoFirebasePulls: View {
    var body: some View {
  

        TaskListView2()
        
    }
}

struct SimpleNoFirebasePulls_Previews: PreviewProvider {
    static var previews: some View {
        SimpleNoFirebasePulls()
    }
}



// MODEL
struct Task2: Identifiable {
    var id: String = UUID().uuidString
    var title : String
    var completed: Bool
}

#if DEBUG
let testDataTasks2 = [
    Task2(title: "yooooo", completed: true),
    Task2(title: "Haaaaaaaa", completed: true),
    Task2(title: "yoofvrvrvrvooo", completed: false),
    Task2(title: "dddddddo", completed: true)
]

#endif

// VIEW

// list out items in list
struct TaskListView2 : View {
    
    let tasks = testDataTasks2
    var body: some View {
        VStack(alignment: .leading) {
            List(tasks) { item in
                TaskCell2(task: item)
            }
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    
                }) {
                    Text("add a task")
                }
        )
        .navigationTitle(Text("Task"))
    }
}

// Checkbox
struct TaskCell2 : View {
    let task : Task2
    var body: some View {
        Image(systemName: task.completed ? "checkmark.circle.fill": "circle"  )
            .resizable()
            .frame(width: 20, height: 20)
        Text(task.title)
    }
}
