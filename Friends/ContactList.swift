//
//  ContactList.swift
//  Friends
//
//  Created by s5014219 on 13/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

let fileName = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent("contact.plist")
class ContactList {
    var entries = [Contact]()
    
    //writes all of the entries to afile for persistent saving of photos
    func save(){
        let propertyList: NSArray = entries.map{ $0.propertyList() }
        propertyList.writeToFile(fileName, atomically: true)
    }
    
    //loads photos from a file into the entries array
    func load(){
        if NSArray(contentsOfFile: fileName) == nil {
            save()
        }
        let fileContent = NSArray(contentsOfFile: fileName) as! Array<NSDictionary>
        entries = fileContent.map { Contact(propertyList: $0)}
    }
}