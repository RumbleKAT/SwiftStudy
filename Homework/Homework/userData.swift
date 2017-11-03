//
//  userData.swift
//  Homework
//
//  Created by 송명진 on 2017. 10. 30..
//  Copyright © 2017년 송명진. All rights reserved.
//

import Foundation

class UserDatas: Codable{
    let userdatas: [UserData]
    init(userdatas: [UserData]){
        self.userdatas = userdatas
    }
}

class UserData: Codable {
    let name_title:String
    let name_first:String
    let name_last:String

    let picture_thumbnail:String
    let picture_medium:String
    let picture_large:String
    
    let email:String
    let cell:String
    let nation: String
    
    init(N:Name, p:Picture, e: String, c: String, n: String) {
        name_title = N.title.firstUppercased
        name_first = N.first.firstUppercased
        name_last = N.last.firstUppercased
        picture_thumbnail = p.thumbnail
        picture_medium  = p.medium
        picture_large = p.large
        email = e
        cell = c
        nation = n
    }
    
    // Type Method - throwing method
    static func UserDataURL() throws -> URL {
        let fileManager = FileManager.default
        let documentURL: URL
        let todosURL: URL
        
        documentURL = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory,
                                          in: FileManager.SearchPathDomainMask.userDomainMask,
                                          appropriateFor: nil, create: false)
        todosURL = documentURL.appendingPathComponent("datas.plist")
        return todosURL
    }
    
}

let didUpdateTodoListNotification: Notification.Name = Notification.Name.init("did update best friend list")

var datas: [UserData] = {
    
    do {
        let userData: Data = try Data(contentsOf: UserData.UserDataURL())
        let decoder: PropertyListDecoder = PropertyListDecoder()
        let datas: [UserData]?
        
        datas = try? decoder.decode([UserData].self, from: userData)
        return datas ?? []
    } catch {
        print(error.localizedDescription)
    }
    
    return []
}()


// Global Function
func saveCurrentData() {
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(datas)
        try data.write(to: UserData.UserDataURL())
    } catch {
        print(error.localizedDescription)
    }
}


struct Name {
    let title: String
    let first: String
    let last: String
}

struct Picture{
    let large: String
    let medium: String
    let thumbnail: String
}

