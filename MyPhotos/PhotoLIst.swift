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
        let propertyList: NSArray = entries.map{ $0.propertyList() }
            let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            let fileName = documentsDirectory.stringByAppendingPathComponent("photo.plist")
            propertyList.writeToFile(fileName, atomically: true)
    }
    
    //loads photos from a file into the entries array
    func load(){
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = documentsDirectory.stringByAppendingPathComponent("photo.plist")
        let fileContent = NSArray(contentsOfFile: fileName) as! Array<NSDictionary>
        entries = fileContent.map { Photo(propertyList: $0)}
    }
}
