//
//  TodoListViewProtocol.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

protocol TodoListViewProtocol: class {
    var presenter: TodoListPresenterProtocol? { get set }
    
    func refreshTodoList()
    func showEmptyView()
    func hideEmptyView()
    
    func showError(_ error: String)
    func showLoading()
    func hideLoading()
}
