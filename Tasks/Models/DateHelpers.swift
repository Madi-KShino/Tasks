//
//  DateHelpers.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}

