//
//  TimelineEntry+CoreDataProperties.swift
//  Friends
//
//  Created by s5014219 on 18/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TimelineEntry {

    @NSManaged var image: NSData
    @NSManaged var siteData: String
    @NSManaged var text: String?
    @NSManaged var account: NSSet

}
