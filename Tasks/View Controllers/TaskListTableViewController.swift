//
//  TaskListTableViewController.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    
    }
    
    // MARK: - TABLE VIEW 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        let taskToDisplay = TaskController.sharedInstance.tasks[indexPath.row]
        cell.textLabel?.text = taskToDisplay.name

        return cell
    }
    
    //MARK: - DELETE CELLS
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let taskToDelete = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.remove(taskToRemove: taskToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailTVC", let indexPath = tableView.indexPathForSelectedRow {
            let destinationTVC = segue.destination as? TaskDetailTableViewController
            let taskToDisplay = TaskController.sharedInstance.tasks[indexPath.row]
            destinationTVC?.taskLandingPad = taskToDisplay
        }
    }
}
