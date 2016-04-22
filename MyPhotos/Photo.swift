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
    
    /*convenience init(title: String? = nil, tag: String, url: String, imageData: NSData? = nil){
        var tags = tag.componentsSeparatedByString(",").flatMap {
            var temp: String = $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return temp == "" ? nil : temp
        }
        self.init(title: String? = nil, tags: [String]? = nil, url: String, imageData: NSData? = nil)
    }*/
    
    //returns a String of comma seperated values from the input string
    func toStringTag(var tag: [String]) -> String{
        let first: String = tag.removeFirst()
        let memes = tag.reduce(first, combine: { " \($0), \($1)" })
        
        return memes
    }
}