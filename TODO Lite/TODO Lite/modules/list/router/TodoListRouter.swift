//
//  TodoListRouter.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation
import UIKit

class TodoListRouter: TodoListRouterProtocol {
    static func initializeModule() -> UIViewController {
        let storyboard = UIStoryboard.init(name: "TodoList", bundle: nil)
        let navController = storyboard.instantiateInitialViewController() as? UINavigationController
        guard let navControllerUnwpd = navController, let view = navControllerUnwpd.childViewControllers.first as? TodoListViewController else { fatalError("Could not instantiate TodoListViewController") }
        
        let interactor: TodoListInteractorInputProtocol = TodoListInteractor()
        let router: TodoListRouterProtocol = TodoListRouter()
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return navControllerUnwpd
    }
    
    func presentDetailed(for todo: TodoItemProtocol, from view: TodoListViewProtocol) {
        
    }
    
    func presentAddTodo(from view: TodoListViewProtocol) {
        let controller = AddTodoRouter.initializeModule()
        (AppDelegate.shared.window?.rootViewController as? UINavigationController)?.viewControllers.last?.present(controller, animated: false, completion: nil)
    }
}
