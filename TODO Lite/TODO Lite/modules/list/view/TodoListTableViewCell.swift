//
//  TodoListTableViewCell.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var completetedIndicatorLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        categoryLabel.text = ""
        dateCreatedLabel.text = ""
        completetedIndicatorLabel.isHidden = true
    }
    
    func update(with todo: TodoItemProtocol) {
        dateCreatedLabel.isHidden = todo.isCompleted
        completetedIndicatorLabel.isHidden = !todo.isCompleted
        
        nameLabel.text = todo.name
        categoryLabel.text = TodoItem.TodoPriority(rawValue: todo.priority)?.visual
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppRelative.datentime.rawValue
        dateCreatedLabel.text = dateFormatter.string(from: todo.date)
    }
}
