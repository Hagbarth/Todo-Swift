//
//  TodoItem.swift
//  Todo
//
//  Created by Emil Rasmussen on 25/10/14.
//  Copyright (c) 2014 Emil Rasmussen. All rights reserved.
//

import Foundation
import CoreData

public class TodoItem: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var done: NSNumber
    @NSManaged var dueDate: NSDate
    @NSManaged var timestamp: NSDate

}
