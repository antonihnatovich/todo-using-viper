//
//  AddTodoPresenter.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation
import UIKit

class AddTodoPresenter: AddTodoPresenterProtocol {
    var view: AddTodoViewProtocol?
    var interactor: AddTodoInteractorInputProtocol?
    var router: AddTodoRouterProtocol?
    
    var todoPriorities: [TodoItem.TodoPriority] = TodoItem.TodoPriority.all
    var todoItemPriority: TodoItem.TodoPriority?
    
    init(view: AddTodoViewProtocol?, interactor: AddTodoInteractorInputProtocol, router: AddTodoRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func addTodo(with title: String?) {
        
        guard let title = title, !title.isEmpty else {
            view?.showError(for: .title)
            return
        }
        guard let priority = todoItemPriority else {
            view?.showError(for: .category)
            return
        }
        
        interactor?.addTodo(with: title, and: priority.rawValue)
    }
}

// MARK: AddTodoInteractorOutputProtocol

extension AddTodoPresenter: AddTodoInteractorOutputProtocol {
    
    func didAddTodo() {
        view?.dismiss()
    }
}
