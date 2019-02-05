//
//  AddTodoInteractor.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

class AddTodoInteractor: AddTodoInteractorInputProtocol {
    var presenter: AddTodoInteractorOutputProtocol?
    
    func addTodo(with title: String, and priority: Int) {
        let todo = TodoItem(id: TodoStoreManager<TodoItem>.highestId() + 1, name: title, priority: priority, date: Date(), isCompleted: false)
        TodoStoreManager<TodoItem>.add(todo: todo).perform()
        presenter?.didAddTodo()
    }
}
