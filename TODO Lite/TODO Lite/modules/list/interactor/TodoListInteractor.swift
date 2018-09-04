//
//  TodoListInteractor.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

class TodoListInteractor: TodoListInteractorInputProtocol {
    
    var presenter: TodoListInteractorOutputProtocol?
    
    func retrieveTodoItems() {
        let items = TodoStoreManager<TodoItem>.readTodos()
        presenter?.didRetrievedTodoItems(items: items)
    }
    
    func removeItem<A: TodoItemProtocol>(todo: A) {
        TodoStoreManager<A>.remove(todo: todo).perform()
        presenter?.didRemoved(todo: todo)
    }
    
    func add<A: TodoItemProtocol>(todo: A) {
        TodoStoreManager<A>.add(todo: todo).perform()
        presenter?.didAdd(todo: todo)
    }
}
