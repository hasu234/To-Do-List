//
//  ToDoItems.swift
//  ToDoApp
//
//  Created by macOS High Sierra on 20/11/18.
//  Copyright © 2018 vitex vegundo. All rights reserved.
//

import Foundation

struct ToDoItems : Codable {
    var title : String
    var completed : Bool
    var createdAt : Date
    var itemIdeantifier : UUID
    
    func saveItem(){
        DataManager.save(Object: self, with: itemIdeantifier.uuidString)
    }
    
    func deleteItem(){
        DataManager.delete(filename: itemIdeantifier.uuidString)
        
    }
    
    mutating func markAsCompleted(){
        self.completed = true
        DataManager.save(Object: self, with: itemIdeantifier.uuidString)
    }
}
