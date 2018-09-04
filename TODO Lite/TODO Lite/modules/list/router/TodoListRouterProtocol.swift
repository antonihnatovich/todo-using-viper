//
//  TodoListRouterProtocol.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation
import UIKit

protocol TodoListRouterProtocol: class {
    static func initializeModule() -> UIViewController
    
    func presentDetailed(for todo: TodoItemProtocol, from view: TodoListViewProtocol)
    func presentAddTodo(from view: TodoListViewProtocol)
}
