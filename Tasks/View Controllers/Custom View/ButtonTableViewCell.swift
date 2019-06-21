//
//  ButtonTableViewCell.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

//MARK: - PROTOCOLS
protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    //MARK: - IBOUTLETS
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - IBACTIONS
    @IBAction func buttonTapped(_ sender: Any) {
        cellDelegate?.buttonCellButtonTapped(self)
    }
    
    //DELEGATE PROPERTY
    weak var cellDelegate: ButtonTableViewCellDelegate?
    
    func updateButton(_ isComplete: Bool) {
        switch isComplete {
        case false:
            completeButton.setImage(UIImage(named: "unchecked"), for: .normal)
        case true:
            completeButton.setImage(UIImage(named: "checked"), for: .normal)
        }
    }
    
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}

