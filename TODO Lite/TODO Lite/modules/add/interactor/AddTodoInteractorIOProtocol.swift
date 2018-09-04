//
//  AddTodoInteractorIOProtocol.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

protocol AddTodoInteractorInputProtocol: class {
    var presenter: AddTodoInteractorOutputProtocol? { get set }
    func addTodo(with title: String, and category: String)
}

protocol AddTodoInteractorOutputProtocol: class {
    func didAddTodo()
}
