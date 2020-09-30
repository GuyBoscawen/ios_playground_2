//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 23/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import Foundation

struct ExploreItem {
    var name: String
    var image: String
}

extension ExploreItem {
    init(dict: [String: AnyObject]) {
        self.name = dict["name"] as! String
        self.image = dict["image"] as! String
    }
}
