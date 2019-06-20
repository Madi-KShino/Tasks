//
//  TaskDetailTableViewController.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    var dueDateValue: Date?
    var taskLandingPad: Task? {
        didSet {
            updateView()
        }
    }
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextField.inputView = dueDatePicker
        updateView()
    }
    
    //MARK: - IBACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, name != ""
            else { return }
        if let updatedTask = taskLandingPad {
            TaskController.sharedInstance.updateExisting(task: updatedTask, name: name, note: notesTextField.text, due: dueDateValue)
        } else {
            TaskController.sharedInstance.addTaskWith(newName: name, note: notesTextField.text, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        nameTextField.text = ""
        notesTextField.text = ""
        dueTextField.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        dueTextField.text = dueDatePicker.date.stringValue()
        dueDateValue = dueDatePicker.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        nameTextField.resignFirstResponder()
        dueTextField.resignFirstResponder()
        dueDatePicker.resignFirstResponder()
        notesTextField.resignFirstResponder()
    }
    
    //MARK: - PRIVATE FUNCTIONS
    private func updateView() {
        guard let existingTask = taskLandingPad else { return }
        nameTextField.text = existingTask.name
        dueTextField.text = existingTask.dueDate?.stringValue()
        notesTextField.text = existingTask.notes
    }
}
