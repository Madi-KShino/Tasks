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
    
    //MARK: - FETCH
    var fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "dueDate", ascending: false)]
        
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing the fetch request")
        }
    }
    
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
        CoreDataStack.managedObjectContext.delete(taskToRemove)
        saveToPersistentStore()
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
}
