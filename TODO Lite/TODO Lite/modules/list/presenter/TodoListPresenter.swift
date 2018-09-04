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
    }
    
    func todo(at index: Int) -> TodoItemProtocol {
        return todos[index]
    }
    
    func addTodo() {
        router?.presentAddTodo(from: view!)
    }
    
    func removeTodo(at index: Int) {
        guard let todo = todos[index] as? TodoItem else { fatalError("Chosen item to delete is not a TodoItem") }
        interactor?.removeItem(todo: todo)
    }
    
    func onError(_ error: Error) {
        Swift.print("[TodoListPresenter] Error did emmit: \(error.localizedDescription)")
        view?.showError(error)
    }
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    func didRetrievedTodoItems(items: [TodoItemProtocol]) {
        todos.removeAll()
        todos.append(contentsOf: items)
        todos.reverse()
        view?.refreshTodoList()
    }
    
    func didRemoved(todo: TodoItemProtocol) {
        guard let index = todos.index(where: {$0.id == todo.id}) else { fatalError("Index of chosen item could not be found") }
        todos.remove(at: index)
    }
    
    func didAdd(todo: TodoItemProtocol) {
        todos.insert(todo, at: 0)
        view?.refreshTodoList()
    }
}
