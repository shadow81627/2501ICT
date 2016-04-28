//
//  PhotoLIst.swift
//  MyPhotos
//
//  Created by s5014219 on 26/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

class PhotoList {
    var entries = [Photo]()
    
    //writes all of the entries to afile for persistent saving of photos
    func save(){
        for entry in entries{
            let propertyList = entry.propertyList()
            let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            let fileName = documentsDirectory.stringByAppendingPathComponent("photo.plist");
            propertyList.writeToFile(fileName, atomically: true)
        }
    }
    
    //loads photos from a file into the entries array
    func load(){
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = documentsDirectory.stringByAppendingPathComponent("photo.plist")
        let optionalArray = NSDictionary(contentsOfFile: fileName)
        //for pl in optionalArray! {
            let photo = Photo(propertyList: optionalArray!)
            entries.insert(photo, atIndex: 0)
        //}
    }
}