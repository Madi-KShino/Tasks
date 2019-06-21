//
//  TableViewController.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/20/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, ButtonTableViewCellDelegate, NSFetchedResultsControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedInstance.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - TABLE VIEW DATA

    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.sharedInstance.fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell,
            let task = TaskController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row]
            else { return UITableViewCell()}
        cell.textLabel?.text = task.name
        cell.cellDelegate = self
        cell.update(withTask: task)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionIndex = Int(TaskController.sharedInstance.fetchedResultsController.sections?[section].name ?? "zero")
        if sectionIndex == 0 {
            return "Tasks To Complete"
        } else {
            return "Completed Tasks"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let targetTask = TaskController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row]
                else { return }
           TaskController.sharedInstance.remove(taskToRemove: targetTask)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailTVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let taskToDisplay = TaskController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row]
                else { return }
            let destinationTVC = segue.destination as? TaskDetailTableViewController
            destinationTVC?.taskLandingPad = taskToDisplay
            destinationTVC?.dueDateValue = taskToDisplay.dueDate
        }
    }
    
    //MARK: - PROTOCOL CONFORMATION
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        guard let task = TaskController.sharedInstance.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        TaskController.sharedInstance.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch (type) {
        case NSFetchedResultsChangeType.insert:
            self.tableView?.insertSections(NSIndexSet.init(index: sectionIndex) as IndexSet, with: .fade)
        case NSFetchedResultsChangeType.delete:
            self.tableView.deleteSections(NSIndexSet.init(index: sectionIndex) as IndexSet, with: .fade)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

