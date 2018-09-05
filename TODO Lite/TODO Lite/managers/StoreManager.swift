//
//  StoreManager.swift
//  TODO Lite
//
//  Created by Anton Developer on 9/1/18.
//  Copyright © 2018 Anton Developer. All rights reserved.
//

import Foundation

enum ActualDataObserverManager {
    
    enum DateKeys: String {
        case login = "com.antonson.todolite.time"
    }
    
    static func checkIfDateIsOver() {
        let dateFormatter = DateFormatter()
        guard let previewsAppEntryDate = UserDefaults.standard.string(forKey: DateKeys.login.rawValue), let date = dateFormatter.date(from: previewsAppEntryDate) else {
            ActualDataObserverManager.renewLoginDate()
            return
        }
        
        if Calendar.current.isDateInYesterday(date) {
            ActualDataObserverManager.renewLoginDate()
            TodoStoreManager<TodoItem>.removeAll().perform()
        }
    }
    
    static func renewLoginDate() {
        defer { UserDefaults.standard.synchronize() }
        let dateFormatter = DateFormatter()
        let todaysParams = dateFormatter.string(from: Date())
        UserDefaults.standard.set(todaysParams, forKey: DateKeys.login.rawValue)
    }
}

enum TodoStoreManager<A: TodoItemProtocol> {
    
    private enum UserDefaultsKey: String {
        case todo = "com.antonson.todolite.todo."
        case id = "com.antonson.todolite.id"
        case time = "com.antonson.todolite.time"
    }
    
    internal enum TodoState: String {
        case all
        case inProgress
        case done
        case paused
    }
    
    case add(todo: A)
    case remove(todo: A)
    case removeAll()
    
    func perform() {
        switch self {
        case .add(let todo):
            self.add(for: todo)
            break
        case .remove(let todo):
            self.remove(for: todo)
            break
        case .removeAll:
            self.removeAll()
            break
        }
    }
    
    internal static func readTodos() -> [TodoItemProtocol] {
        var todos: [TodoItemProtocol] = []
        let todoUids = todoIds()
        todoUids.forEach({
            let data = UserDefaults.standard.data(forKey: UserDefaultsKey.todo.rawValue + $0)
            if let dataUnwrapped = data, let todo = try? JSONDecoder().decode(TodoItem.self, from: dataUnwrapped) { todos.append(todo) }
        })
        return todos
    }
    
    // MARK: Private
    
    private func add(for todo: A) {
        let data = try? JSONEncoder().encode(todo)
        guard let dataUnwrapped = data else { fatalError("Could not create data from object TodoItem") }
        defer { UserDefaults.standard.synchronize() }
        UserDefaults.standard.set(dataUnwrapped, forKey: UserDefaultsKey.todo.rawValue + "\(todo.id)")
        updateIdList()
    }
    
    private func update(for todo: A) {
        let data = try? JSONEncoder().encode(todo)
        guard let dataUnwrapped = data else { fatalError("Could not create data from object TodoItem") }
        defer { UserDefaults.standard.synchronize() }
        UserDefaults.standard.set(dataUnwrapped, forKey: UserDefaultsKey.todo.rawValue + "\(todo.id)")
    }
    
    private func remove(for todo: A) {
        defer { UserDefaults.standard.synchronize() }
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.todo.rawValue + "\(todo.id)")
        updateIdList()
    }
    
    private func removeAll() {
        defer { UserDefaults.standard.synchronize() }
        TodoStoreManager<TodoItem>.todoIds()
            .forEach({ UserDefaults.standard.removeObject(forKey: UserDefaultsKey.todo.rawValue + $0)})
        updateIdList()
    }
    
    private func updateIdList() {
        switch self {
        case .add(let todo):
            var ids = UserDefaults.standard.string(forKey: UserDefaultsKey.id.rawValue) ?? ""
            defer { UserDefaults.standard.synchronize() }
            ids += "_\(todo.id)"
            UserDefaults.standard.set(ids, forKey: UserDefaultsKey.id.rawValue)
            break
        case .remove(let todo):
            var ids = TodoStoreManager.todoIds()
            defer { UserDefaults.standard.synchronize() }
            guard let index = ids.index(where: {$0.elementsEqual("\(todo.id)")}) else { fatalError("UserDefaults does not contain such todo")}
            ids.remove(at: index)
            let idsUpdated = "_" + ids.joined(separator: "_")
            UserDefaults.standard.set(idsUpdated, forKey: UserDefaultsKey.id.rawValue)
            break
        case .removeAll:
            defer { UserDefaults.standard.synchronize() }
            UserDefaults.standard.removeObject(forKey: UserDefaultsKey.id.rawValue)
            break
        }
    }
    
    private static func parseIds(from string: String) -> [String] {
        guard !string.isEmpty && string.contains("_") else { return [] }
        return string.split(separator: "_").map{String($0)}
    }
    
    private static func todoIds() -> [String] {
        return parseIds(from: UserDefaults.standard.string(forKey: UserDefaultsKey.id.rawValue) ?? "")
    }
    
    static func highestId() -> Int {
        var todoIds = TodoStoreManager.todoIds()
        todoIds.sort(by: {Int($0) ?? 0 > Int($1) ?? 0})
        return Int(todoIds.first ?? "0") ?? 0
    }
}
