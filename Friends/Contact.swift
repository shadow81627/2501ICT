//
//  Contact.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation
import CoreData

//
// A Contact has an address firstname and lastname of type String, An image of type NSData and a URL of type NSUrl.
//
class Contact: NSManagedObject {
    
    // The fullName function returns the full name of a contact
    func fullName() -> String {
            return firstName + " " + lastName
    }
}