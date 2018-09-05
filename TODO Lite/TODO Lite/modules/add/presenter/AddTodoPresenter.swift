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
    
    init(view: AddTodoViewProtocol?, interactor: AddTodoInteractorInputProtocol, router: AddTodoRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func addTodo(with title: String?, and category: String?) {
        
        guard let title = title, !title.isEmpty else {
            view?.showError(for: .title)
            return
        }
        guard let category = category, !category.isEmpty, category.count > 0, (category.contains {["A", "B", "C", "D", "E"].contains($0)}) else {
            view?.showError(for: .category)
            return
        }
        
        interactor?.addTodo(with: title, and: category)
    }
}

// MARK: AddTodoInteractorOutputProtocol

extension AddTodoPresenter: AddTodoInteractorOutputProtocol {
    
    func didAddTodo() {
        view?.dismiss()
    }
}
