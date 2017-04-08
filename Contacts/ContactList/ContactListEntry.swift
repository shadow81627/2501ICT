//
//  ContactListEntry.swift
//  ContactList
//
//  Created by s5014219 on 23/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

// The contactList entry subclasses the person class
class ContactListEntry: Person {
    
    // The address of a person
    var address: String?
    // The phone number of a person
    var phoneNumber: String?
    
    // Initaliser for the ContactListEntry class
    init(firstName: String, lastName: String, yearOfBirth: Int? = nil, middleName: String? = nil, address: String? = nil, phoneNumber: String? = nil) {
        self.address = address
        self.phoneNumber = phoneNumber
        super.init(firstName: firstName, lastName: lastName, yearOfBirth: yearOfBirth, middleName: middleName)
    }
}