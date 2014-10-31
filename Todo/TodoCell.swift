//
//  TodoCell.swift
//  Todo
//
//  Created by Emil Rasmussen on 25/10/14.
//  Copyright (c) 2014 Emil Rasmussen. All rights reserved.
//

import UIKit
import CoreData

class TodoCell: UITableViewCell {
    var item: TodoItem?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func remove(sender: AnyObject) {
        TodoStore().removeTodo(item!)
    }
}
