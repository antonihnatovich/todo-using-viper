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
    
    func addTodo(with title: String?, and category: String?)
    func didAddTodo()
}
