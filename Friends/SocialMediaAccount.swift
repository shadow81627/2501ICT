//
//  SocialMediaAccount.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

//This data structure holds the ID type and thecontact for a social media account
class SocialMediaAccount: NSObject {
    
    //The unique ID of the account type string
    var identifier: String
    //the type of account type string
    var type: String
    //the contact which the account belongs
    var contact: Contact
    
    //the initialiser for the class takes a String identifier, type and a Contact
    init(identifier: String, type: String, contact: Contact){
        self.identifier = identifier
        self.type = type
        self.contact = contact
    }
    
    //creates a social media account from saved account data of type NSDictionary
    convenience init(propertyList: NSDictionary){
        self.init(
        identifier: (propertyList["identifier"] as? String)!,
        type: (propertyList["type"] as? String)!,
        contact: (propertyList["Contact"] as? Contact)!)
    }
    
    //returns a dictionaray of social media account detials
    func propertyList() -> NSDictionary {
        return ["identifier": identifier, "type": type, "contact": contact]
    }
    
}