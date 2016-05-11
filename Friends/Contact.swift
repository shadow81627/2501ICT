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
class Contact {
    
    var address: String
    
    var firstName: String
    var lastName: String
    
    var image: NSData?
    var imageURL: NSURL
    
    //initialiser for the Contact class
    init(address: String, firstName: String, lastName: String, image: NSData?, imageURL: NSURL){
            self.address = address
            self.firstName = firstName
            self.lastName = lastName
            self.image = image
            self.imageURL = imageURL
    }
    
    
    //Secondary initialiser for the Contact class that takes a String for the URL
    convenience init(address: String, firstName: String, lastName: String, image: NSData?, imageURL: String){
        self.init(address: address, firstName: firstName, lastName: lastName, image: image, imageURL: imageURL)
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.imageURL = NSURL(string: imageURL)!
    }
    
    
}