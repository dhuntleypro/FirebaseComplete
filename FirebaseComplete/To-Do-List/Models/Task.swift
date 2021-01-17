//
//  ddddd.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/16/21.
//

import SwiftUI
import Combine

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
