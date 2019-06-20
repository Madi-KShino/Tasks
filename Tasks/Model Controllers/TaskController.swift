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
        Task(name: newName, notes: note, dueDate: due)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func updateExisting(task: Task, name: String, note: String?, due: Date?) {
        task.name = name
        task.notes = note
        task.dueDate = due
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func remove(taskToRemove: Task) {
        taskToRemove.managedObjectContext?.delete(taskToRemove)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func toggleIsCompleteFor(task:Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    //MARK: - PERSISTENCE
    func saveToPersistentStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch {
            print("Error saving Manage Object Context")
        }
    }
    
    private func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.managedObjectContext.fetch(request)) ?? []
    }
}
