//
//  FilterManager.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 26/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
    func fetch(completionHandler: (_ items: [FilterItem]) -> Swift.Void) {
        var items: [FilterItem] = []
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
        completionHandler(items)
    }
}
