//
//  ButtonTableViewCell.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    //MARK: - IBOUTLETS
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - IBACTIONS
    @IBAction func buttonTapped(_ sender: Any) {
    }
    
    func updateButton(_ isComplete: Bool) {
        switch isComplete {
        case true:
            completeButton.setImage(UIImage(named: "checked"), for: .normal)
        case false:
            completeButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        
    }
}
