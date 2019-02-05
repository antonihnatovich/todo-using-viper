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
    var priority: Int { get set }
    var date: Date { get set }
    var isCompleted: Bool { get set }
}

class TodoItem: TodoItemProtocol, Equatable {
    
    enum TodoPriority: Int {
        case a = 1, b = 2, c = 3, d = 4, e = 5
        
        var visual: String {
            var s = ""
            switch self {
                case .a:
                s = "A"
                case .b:
                s = "B"
                case .c:
                s = "C"
                case .d:
                s = "D"
                case .e:
                s = "E"
            }
            return s
        }
        
        static var all: [TodoPriority] {
            return [.a, .b, .c, .d, .e]
        }
    }
    
    var id: Int
    var name: String
    var priority: Int
    var date: Date
    var isCompleted: Bool
    
    init(id: Int, name: String, priority: Int, date: Date, isCompleted: Bool) {
        self.id = id
        self.name = name
        self.priority = priority
        self.date = date
        self.isCompleted = isCompleted
    }
    
    static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id == rhs.id && lhs.name.elementsEqual(rhs.name)
            && lhs.priority == rhs.priority
    }
}
