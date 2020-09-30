//
//  FilterItem.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 26/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import Foundation

class FilterItem: NSObject {
    let filter: String
    let name: String
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as! String
        filter = dict["filter"] as! String
    }
}


