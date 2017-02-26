//
//  TaskManager.swift
//  reMIND
//
//  Created by David de Tena on 25/02/2017.
//  Copyright © 2017 David de Tena. All rights reserved.
//

import Foundation

/// This class is responsible for managing our tasks, including saving and loading them from UserDefaults
class TaskManager {
    
    // MARK: - Properties
    static let sharedInstance = TaskManager()     // Singleton
    var tasks : [[String : String]] = [[String : String]]()
    
    // MARK: - Functions
    func save(){
        UserDefaults.standard.set(tasks, forKey: "tasks")
    }
    
    func load(){
        if let array = UserDefaults.standard.array(forKey: "tasks") as? [[String:String]]{
            tasks = array
        }
    }
}
