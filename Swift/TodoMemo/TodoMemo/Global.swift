//
//  Global.swift
//  TodoMemo
//
//  Created by yagom on 2017. 10. 18..
//  Copyright © 2017년 yagom. All rights reserved.
//

import Foundation

// Global Variables
var dateFormatter: DateFormatter = {
    let formatter: DateFormatter = DateFormatter()
    formatter.timeStyle = DateFormatter.Style.short
    formatter.dateStyle = DateFormatter.Style.long
    return formatter
}()

let didUpdateTodoListNotification: Notification.Name = Notification.Name.init("did update todo list")

var todos: [TodoInfo] = {
    
    do {
        let todoData: Data = try Data(contentsOf: TodoInfo.todoDataURL())
        let decoder: PropertyListDecoder = PropertyListDecoder()
        let todos: [TodoInfo]?
        
        todos = try? decoder.decode([TodoInfo].self, from: todoData)
        return todos ?? []
    } catch {
        print(error.localizedDescription)
    }
    
    return []
}()

// Global Function
func saveCurrentTodo() {
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(todos)
        try data.write(to: TodoInfo.todoDataURL())
    } catch {
        print(error.localizedDescription)
    }
}
