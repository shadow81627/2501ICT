//
//  SocialMediaAccount+CoreDataProperties.swift
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

extension SocialMediaAccount {

    //The unique ID of the account type string
    @NSManaged var identifier: String
    //the type of account type string
    @NSManaged var type: String
    //the contact which the account belongs
    @NSManaged var contact: NSManagedObject
    //the list of timeline entries
    @NSManaged var entries: TimelineEntry?
}
