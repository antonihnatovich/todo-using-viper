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
    var isComlited: Bool { get set }
}

struct TodoItem: TodoItemProtocol, Equatable {
    var id: Int
    var name: String
    var category: String
    var date: Date
    var isComlited: Bool
}
