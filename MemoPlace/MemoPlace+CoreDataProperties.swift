//
//  MemoPlace+CoreDataProperties.swift
//  MemoPlace
//
//  Created by The Bao on 11/11/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import CoreData

extension MemoPlace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoPlace> {
        let request = NSFetchRequest<MemoPlace>(entityName: "MemoPlace")
        let sortDescriptor = NSSortDescriptor(key: #keyPath(MemoPlace.name), ascending: true)
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
