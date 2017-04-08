//
//  Photo.swift
//  MyPhotos
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

class Photo: NSObject {
    
    var title: String
    var tag: [String]?
    var url: String
    dynamic var imageData: NSData?
    
    //creates a new Photo with given details
    init(title: String, tag: [String]? = nil, url: String, imageData: NSData? = nil){
        self.title = title
        self.tag = tag
        self.url = url
        self.imageData = imageData
    }
    
    //creates a photo from saved photo data
    convenience init(propertyList: NSDictionary){
        self.init(title: " ", url: " ")
        title = (propertyList["title"] as? String)!
        tag = propertyList["tag"] as? [String]
        url = (propertyList["url"] as? String)!
    }
    
    //returns a dictionaray of the photo details
    func propertyList() -> NSDictionary {
        if tag == nil {
            return ["title": title, "tag": [""], "url": url]
        }
            return ["title": title, "tag": tag!, "url": url]
    }
}