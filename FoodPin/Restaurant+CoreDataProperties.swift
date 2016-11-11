//
//  Restaurant+CoreDataProperties.swift
//  FoodPin
//
//  Created by The Bao on 11/11/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Restaurant.name), ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var location: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var image: NSData?
    @NSManaged public var isVisited: Bool
    @NSManaged public var rating: String?

}
