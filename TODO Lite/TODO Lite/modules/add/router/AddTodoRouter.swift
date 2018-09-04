//
//  AddTodoRouter.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation
import UIKit

class AddTodoRouter: AddTodoRouterProtocol {
    
    static func initializeModule() -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "AddTodo", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? AddTodoViewController else { fatalError("Could not instantiate AddTodoViewController") }
        
        let interactor: AddTodoInteractorInputProtocol = AddTodoInteractor()
        let router: AddTodoRouterProtocol = AddTodoRouter()
        let presenter: AddTodoPresenterProtocol & AddTodoInteractorOutputProtocol = AddTodoPresenter(view: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
}
