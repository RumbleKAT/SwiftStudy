//
//  TodoInfo.swift
//  TodoMemo
//
//  Created by yagom on 2017. 10. 18..
//  Copyright © 2017년 yagom. All rights reserved.
//

import Foundation

struct TodoInfo: Codable {
    var title: String
    var due: Date
    
    // Type Method - throwing method
    static func todoDataURL() throws -> URL {
        let fileManager = FileManager.default
        let documentURL: URL
        let todosURL: URL
       
        documentURL = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory,
                                          in: FileManager.SearchPathDomainMask.userDomainMask,
                                          appropriateFor: nil, create: false)
        todosURL = documentURL.appendingPathComponent("todo.plist")
        return todosURL
    }
}



