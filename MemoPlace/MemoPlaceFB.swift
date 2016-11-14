//
//  MemoPlaceFB.swift
//  MemoPlace
//
//  Created by The Bao on 11/13/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MemoPlaceFB {
    var name: String!
    var type: String!
    var location: String!
    var phoneNumber: String?
    var rating: String?
    var isVisited: Bool?
    var image: String?

    init(snapshot: FIRDataSnapshot) {
            let snapshotValue = snapshot.value as! [String: Any]
            self.name = snapshotValue["name"] as! String
            self.type = snapshotValue["type"] as! String
            self.location = snapshotValue["location"] as! String
            self.phoneNumber = snapshotValue["phone"] as? String
            self.rating = snapshotValue["rating"] as? String
            self.image = snapshotValue["image"] as? String
            self.isVisited = true
    }
}
