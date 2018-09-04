//
//  TodoListViewController.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, TodoListViewProtocol {
    var presenter: TodoListPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Awesome TODO's Bar"
        presenter?.loadTodos()
    }
    
    // MARK: IBAction
    
    @IBAction func addTodoButtonDidPress(_ sender: UIBarButtonItem) {
        presenter?.addTodo()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.todoCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.todoItem.rawValue) as! TodoListTableViewCell
        if let todo = presenter?.todo(at: indexPath.row) {
            cell.update(with: todo)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.removeTodo(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if presenter?.todoCount ?? 0 == 0 { refreshTodoList() }
        }
    }
}

// MARK: TodoListViewProtocol

extension TodoListViewController {
    
    func refreshTodoList() {
        if presenter?.todoCount ?? 0 > 0 {
            tableView.reloadData()
            hideEmptyView()
        } else {
            showEmptyView()
        }
    }
    
    func showEmptyView() {
        emptyView.isHidden = false
    }
    
    func hideEmptyView() {
        emptyView.isHidden = true
    }
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
