//
//  Contact+CoreDataProperties.swift
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

extension Contact {

    //Takes a string and sets the address string as the given string
    @NSManaged var address: String
    
    //Takes a string and sets the firstName string as the given string
    @NSManaged var firstName: String
    
    //This field holds the image data and is set when there is a URL
    @NSManaged var image: NSData?
    
     //Sets the url and then sets the image data witht he given url
    @NSManaged var imageURL: String
    
     //Takes a string and sets the lastName string as the given string
    @NSManaged var lastName: String
    
    //The list of social media accounts this contact has
    @NSManaged var accounts: NSSet?
    
    
    
    


}
