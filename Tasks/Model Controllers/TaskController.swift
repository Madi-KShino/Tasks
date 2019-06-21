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
//    var tasks: [Task] = []
    
    //MARK: - EDITING FUNCTIONS
    func addTaskWith(newName: String, note: String?, due: Date?) {
        Task(name: newName, notes: note, dueDate: due)
        saveToPersistentStore()
    }
    
    func updateExisting(task: Task, name: String, note: String?, due: Date?) {
        task.name = name
        task.notes = note
        task.dueDate = due
        saveToPersistentStore()
    }
    
    func remove(taskToRemove: Task) {
        taskToRemove.managedObjectContext?.delete(taskToRemove)
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task:Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    //MARK: - PERSISTENCE
    func saveToPersistentStore() {
        let managedOC = CoreDataStack.managedObjectContext
        do {
            try managedOC.save()
        } catch {
            print("Error saving Manage Object Context")
        }
    }

    //MARK: - FETCH
    var fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        let primarySort = NSSortDescriptor(key: "isComplete", ascending: false)
        let secondarySort = NSSortDescriptor(key: "dueDate", ascending: true)
        request.sortDescriptors = [primarySort, secondarySort]
        
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing the fetch request")
        }
    }
}
