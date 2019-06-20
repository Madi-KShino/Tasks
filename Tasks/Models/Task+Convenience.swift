//
//  Task+Convenience.swift
//  Tasks
//
//  Created by Madison Kaori Shino on 6/19/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    @discardableResult
    convenience init(name: String,
                     notes: String?,
                     dueDate: Date?,
                     context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
        self.notes = nil
        self.dueDate = nil
    }
}
