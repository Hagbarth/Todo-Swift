//
//  TodoViewController.swift
//  Todo
//
//  Created by Emil Rasmussen on 25/10/14.
//  Copyright (c) 2014 Emil Rasmussen. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {
    let todoCellIdentifier = "todoCell"
    var todoStore = TodoStore()
    var todoItems : [TodoItem] = []
    var doneItems : [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTodos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Utils
    func updateTodos() {
        todoItems = todoStore.getTodos(true)
        doneItems = todoStore.getTodos(false)
        tableView.reloadData()
    }

    // MARK: - Actions
    @IBAction func addTodo(sender: AnyObject) {
        var todoField: UITextField?
        let alertController = UIAlertController(title: "New todo", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.Default, handler: { (action : UIAlertAction!) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "ok", style: .Default, handler: { (action: UIAlertAction!) -> Void in
            var err : NSError?
            self.todoStore.addTodo(todoField!.text!, error: &err)
            self.updateTodos()
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "my todo"
            todoField = textField
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func clearAllTodos(sender: AnyObject) {
        todoStore.removeAllTodos()
        updateTodos()
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Todos" : "Done"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? todoItems.count : doneItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(todoCellIdentifier, forIndexPath: indexPath) as TodoCell
        let item = indexPath.section == 0 ? todoItems[indexPath.row] as TodoItem : doneItems[indexPath.row] as TodoItem
        cell.textLabel.text = item.title
        cell.item = item
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as TodoCell
        let item = cell.item
        todoStore.toggleDone(item!)
        updateTodos()
    }
    
}
