//
//  SimpleNofirebasePulls.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/16/21.
//

import SwiftUI

struct SimpleNoFirebasePulls: View {
    var body: some View {
  

        TaskListView()
        
    }
}

struct SimpleNoFirebasePulls_Previews: PreviewProvider {
    static var previews: some View {
        SimpleNoFirebasePulls()
    }
}



// MODEL
struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title : String
    var completed: Bool
}

#if DEBUG
let testDataTasks = [
    Task(title: "yooooo", completed: true),
    Task(title: "Haaaaaaaa", completed: true),
    Task(title: "yoofvrvrvrvooo", completed: false),
    Task(title: "dddddddo", completed: true)
]

#endif

// VIEW

// list out items in list
struct TaskListView : View {
    
    let tasks = testDataTasks
    var body: some View {
        VStack(alignment: .leading) {
            List(tasks) { item in
                TaskCell(task: item)
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
struct TaskCell : View {
    let task : Task
    var body: some View {
        Image(systemName: task.completed ? "checkmark.circle.fill": "circle"  )
            .resizable()
            .frame(width: 20, height: 20)
        Text(task.title)
    }
}
