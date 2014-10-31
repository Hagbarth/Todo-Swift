//
//  TodoStore.swift
//  Todo
//
//  Created by Emil Rasmussen on 25/10/14.
//  Copyright (c) 2014 Emil Rasmussen. All rights reserved.
//

import UIKit
import Foundation
import CoreData

public class TodoStore: NSObject {
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    public func addTodo(title : String, error : NSErrorPointer) -> TodoItem {
        let newTodo = NSEntityDescription.insertNewObjectForEntityForName("TodoItem", inManagedObjectContext: self.managedObjectContext!) as TodoItem
        newTodo.title = title
        newTodo.done = false;
        newTodo.timestamp = NSDate()
        newTodo.dueDate = NSDate()
        self.managedObjectContext?.save(error)
        return newTodo;
    }
    
    public func removeTodo(item: TodoItem) {
        self.managedObjectContext?.deleteObject(item)
    }
    
    public func removeAllTodos() {
        for item: TodoItem in getTodos(true) + getTodos(false) {
            self.managedObjectContext?.deleteObject(item)
        }
    }
    
    public func getTodos(done : Bool) -> [TodoItem] {
        let request = NSFetchRequest()
        let err = NSErrorPointer()
        request.entity = NSEntityDescription.entityForName("TodoItem", inManagedObjectContext: self.managedObjectContext!)
        request.predicate = NSPredicate(format: "done!=%@", NSNumber(bool: done))
        let orders = self.managedObjectContext!.executeFetchRequest(request, error: err) as [TodoItem]
        return orders
    }
    
    public func toggleDone(item: TodoItem) {
        let err = NSErrorPointer()
        item.done = !item.done.boolValue
        self.managedObjectContext?.save(err)
    }
}