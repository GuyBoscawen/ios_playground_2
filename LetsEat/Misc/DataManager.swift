//
//  DataManager.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 24/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import Foundation

protocol DataManager {
    func load(file name: String) -> [[String: AnyObject]]
}

extension DataManager {
    func load(file name: String) -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"), let items = NSArray(contentsOfFile: path) else {
            return [[:]]
        }
        
        return items as! [[String: AnyObject]]
    }
}
