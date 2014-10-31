//
//  TodoTests.swift
//  TodoTests
//
//  Created by Emil Rasmussen on 25/10/14.
//  Copyright (c) 2014 Emil Rasmussen. All rights reserved.
//

import UIKit
import Todo
import XCTest

class TodoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanAddAndRemoveTodo() {
        var todoItem: TodoItem?
        let store = TodoStore()
        var err: NSError?
        todoItem = store.addTodo("Test todo", error: &err)
        XCTAssertNotNil(todoItem, "Todo item is nil")
        XCTAssertNil(err, "Error is not nil error: " + err.debugDescription)
        store.removeTodo(todoItem!)
    }
}
