//
//  TaskListTableViewController.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - PROTOCOL FUNC
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        TaskController.sharedInstance.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    // MARK: - TABLE VIEW 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        
        let taskToDisplay = TaskController.sharedInstance.tasks[indexPath.row]
        cell.update(withTask: taskToDisplay)
        cell.cellDelegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let taskToDelete = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.remove(taskToRemove: taskToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailTVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let taskToDisplay = TaskController.sharedInstance.tasks[indexPath.row]
            let destinationTVC = segue.destination as? TaskDetailTableViewController
            
            destinationTVC?.taskLandingPad = taskToDisplay
            destinationTVC?.dueDateValue = taskToDisplay.dueDate
        }
    }
}

//extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
//    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        NSFetchedResultsChangeType
//    }
//}
