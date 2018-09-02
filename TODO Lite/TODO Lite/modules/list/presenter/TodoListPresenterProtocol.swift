//
//  TodoListPresenterProtocol.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

protocol TodoListPresenterProtocol: class {
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    var todos: [TodoItemProtocol] { get set }
    var todoCount: Int { get }
    
    func todo(at index: Int) -> TodoItemProtocol
    func loadTodos()
    func addTodo()
    func removeTodo(at index: Int)
    func presentTodo(at index: Int)
    func onError(_ error: Error)
}
