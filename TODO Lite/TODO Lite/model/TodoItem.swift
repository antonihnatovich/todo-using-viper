//
//  TodoItem.swift
//  TODO Lite
//
//  Created by Anton Developer on 8/31/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

protocol TodoItemProtocol: Codable {
    var id: Int { get set }
    var name: String { get set }
    var category: String { get set }
    var date: Date { get set }
    var isCompleted: Bool { get set }
}

class TodoItem: TodoItemProtocol, Equatable {
    
    var id: Int
    var name: String
    var category: String
    var date: Date
    var isCompleted: Bool
    
    init(id: Int, name: String, category: String, date: Date, isCompleted: Bool) {
        self.id = id
        self.name = name
        self.category = category
        self.date = date
        self.isCompleted = isCompleted
    }
    
    static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id == rhs.id && lhs.name.elementsEqual(rhs.name)
            && lhs.category.elementsEqual(rhs.category)
    }
}
