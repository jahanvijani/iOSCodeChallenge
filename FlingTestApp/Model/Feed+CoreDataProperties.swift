//
//  Feed+CoreDataProperties.swift
//  FlingTestApp
//
//  Created by Jahanvi Vyas on 10/04/2016.
//  Copyright © 2016 Jahanvi Vyas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Feed {

    @NSManaged var feedID: NSNumber?
    @NSManaged var userID: NSNumber?
    @NSManaged var photoTitle: String?
    @NSManaged var userName: String?

}
