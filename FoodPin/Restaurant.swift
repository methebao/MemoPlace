//
//  Restaurant.swift
//  FoodPin
//
//  Created by The Bao on 11/8/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String
    var type: String
    var location: String
    var image: String
    var phoneNumber: String
    var rating: String = ""
    var isVisited: Bool

    init(name: String, type: String, location: String,phoneNumber: String, image: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.image = image
        self.location = location
        self.phoneNumber = phoneNumber
        self.isVisited = isVisited
    }
}
