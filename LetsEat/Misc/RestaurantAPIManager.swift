//
//  RestaurantAPIManager.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 24/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import Foundation

struct RestaurantAPIManager {
    static func loadJSON(file name: String) -> [[String: AnyObject]] {
        var items = [[String: AnyObject]]()
        guard let path = Bundle.main.path(forResource: name, ofType: "json"), let data = NSData(contentsOfFile: path) else {
            return [[:]]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as AnyObject
            
            if let restaurants = json as? [[String: AnyObject]] {
                items = restaurants as [[String: AnyObject]]
            }
        }
        catch {
            print("error serializing JSON: \(error)")
            items = [[:]]
        }
        
        return items
    }
}
