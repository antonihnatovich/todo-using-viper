//
//  TodoListPresenter.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

class TodoListPresenter: TodoListPresenterProtocol {
    internal weak var view: TodoListViewProtocol?
    internal var interactor: TodoListInteractorInputProtocol?
    internal var router: TodoListRouterProtocol?
    internal var todos: [TodoItemProtocol]
    internal var todoCount: Int {
        return todos.count
    }
    
    init(view: TodoListViewProtocol?, interactor: TodoListInteractorInputProtocol, router: TodoListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.todos = []
    }
    
    func loadTodos() {
        interactor?.retrieveTodoItems()
        view?.showLoading()
    }
    
    func todo(at index: Int) -> TodoItemProtocol {
        return todos[index]
    }
    
    func addTodo() {
        // todo
    }
    
    func removeTodo(at index: Int) {
        // todo
    }
    
    func presentTodo(at index: Int) {
        // todo
    }
    
    func onError(_ error: Error) {
        // todo
    }
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    func didRetrievedTodoItems(items: [TodoItemProtocol]) {
        todos.removeAll()
        todos.append(contentsOf: items)
        view?.refreshTodoList()
        view?.hideLoading()
    }
    
    func didRemoved(todo: TodoItemProtocol) {
        // todo
    }
    
    func didAdd(todo: TodoItemProtocol) {
        // todo
    }
}
