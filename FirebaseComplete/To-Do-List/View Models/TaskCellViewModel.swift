//
//  oko.swift
//  FirebaseComplete
//
//  Created by Darrien Huntley on 1/16/21.
//

import SwiftUI
import Combine


// Ceack boxes
class TaskCellViewModel : ObservableObject, Identifiable {
    // referance to a task and can be listened to
    @Published var task : Task
    
    // identifiable
    var id = ""
    
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        // track ID
        $task
            .map { task in
                task.id
            }
            .assign(to: \.id , on: self)
            .store(in: &cancellables)
        
    }
}
