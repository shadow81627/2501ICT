//
//  Contact.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

//
// A Contact has an address firstname and lastname of type String, An image of type NSData and a URL of type NSUrl.
//
class Contact: NSObject {
    
    //Takes a string and sets the address string as the given string
    var address: String
    
    //Takes a string and sets the firstName and lastName string as the given string
    var firstName: String
    var lastName: String
    
    //This field holds the image data and is set when there is a URL
    var image: NSData?
    //Sets the url and then sets the image data witht he given url
    var imageURL: String
    
    //initialiser for the Contact class takes a String address, firstname, lastname NSURL imageURL and can take image data.
    init(address: String, firstName: String, lastName: String, image: NSData? = nil, imageURL: String){
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.imageURL = imageURL
    }
    
    // The fullName function returns the full name of a contact
    func fullName() -> String {
            return firstName + " " + lastName
    }
    
    //creates a contact from saved contact data of type NSDictionary
    convenience init(propertyList: NSDictionary){
        self.init(address: " ", firstName: " ", lastName:" ", imageURL: " ")
        address = (propertyList["address"] as? String)!
        firstName = (propertyList["firstName"] as? String)!
        lastName = (propertyList["lastName"] as? String)!
        imageURL = (propertyList["imageURL"] as? String)!
    }
    
    //returns a dictionaray of contact details address, firstName, lastName and imageURL
    func propertyList() -> NSDictionary {
        return ["address": address, "firstName": firstName, "lastName": lastName, "imageURL": imageURL]
    }
    
}