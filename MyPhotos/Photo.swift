//
//  Photo.swift
//  MyPhotos
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

class Photo {
    
    var title: String?
    var tag: [String]?
    var url: String
    var imageData: NSData?
    
    init(title: String? = nil, tag: [String]? = nil, url: String, imageData: NSData? = nil){
        self.title = title
        self.tag = tag
        self.url = url
        self.imageData = imageData
    }
}