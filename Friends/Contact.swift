//
//  Contact.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit
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
    var imageURL: NSURL
    
    //initialiser for the Contact class takes a String address, firstname, lastname NSURL imageURL and can take image data.
    init(address: String, firstName: String, lastName: String, image: NSData? = nil, imageURL: NSURL){
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.imageURL = imageURL
    }
}