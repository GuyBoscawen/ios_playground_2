//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 25/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import Foundation

class RestaurantDataManager {
    private var items: [RestaurantItem] = []
    
    func fetch(by location: String, with filter: String = "All", completionHandler:(_ items: [RestaurantItem]) -> Void) {
        if let file = Bundle.main.url(forResource: "JSON/\(location)", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let restaurants = try JSONDecoder().decode([RestaurantItem].self, from: data)
                if filter != "All" {
                    items = restaurants.filter({ ($0.cuisines.contains(filter))})
                }
                else { items = restaurants }
            }
            catch {
                print("there was an error \(error)")
            }
        } else {
            print("no bundle")
        }
        completionHandler(items)
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func restaurantItem(at index: IndexPath) -> RestaurantItem {
        return items[index.row]
    }
}
