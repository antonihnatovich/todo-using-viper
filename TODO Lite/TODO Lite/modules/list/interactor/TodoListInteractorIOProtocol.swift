//
//  TodoListInteractorIOProtocol.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

protocol TodoListInteractorInputProtocol: class {
    var presenter: TodoListInteractorOutputProtocol? { get set }
    
    func retrieveTodoItems()
    func removeItem<A: TodoItemProtocol>(todo: A)
    func add<A: TodoItemProtocol>(todo: A)
}

protocol TodoListInteractorOutputProtocol: class {
    
    func didRetrievedTodoItems(items: [TodoItemProtocol])
    func didRemoved(todo: TodoItemProtocol)
    func didAdd(todo: TodoItemProtocol)
}
