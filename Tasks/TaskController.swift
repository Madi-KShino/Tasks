//
//  TaskController.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    //MARK: - SINGLETON & SOURCE OF TRUTH
    static let sharedInstance = TaskController()
    var tasks: [Task] = []
    
    //MARK: - EDITING FUNCTIONS
    func addTaskWith(newName: String, note: String?, due: Date?) {
//        Task(name: newName, notes: note, dueDate: due)
        saveToPersistentStore()
    }
    
    func updateExisting(task: Task, name: String, note: String?, due: Date?) {
        
        saveToPersistentStore()
    }
    
    func remove(taskToRemove: Task) {
        
        saveToPersistentStore()
    }
    
    //MARK: - PERSISTENCE
    func saveToPersistentStore() {
        
    }
    
//    func fetchTask() -> [Task] {
//
//
//    }
    

    
    
}
