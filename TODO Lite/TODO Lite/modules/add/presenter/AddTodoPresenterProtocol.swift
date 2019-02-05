//
//  AddTodoPresenterProtocol.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

protocol AddTodoPresenterProtocol: class {
    var view: AddTodoViewProtocol? { get set }
    var interactor: AddTodoInteractorInputProtocol? { get set }
    var router: AddTodoRouterProtocol? { get set }
    var todoPriorities: [TodoItem.TodoPriority] { get set }
    var todoItemPriority: TodoItem.TodoPriority? { get set }
    
    func addTodo(with title: String?)
    func didAddTodo()
}
