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
    
    //set the tags witha string
    convenience init(title: String? = nil, tag: String, url: String, imageData: NSData? = nil){
        let tags: [String] = tag.componentsSeparatedByString(",").flatMap{
            let temp: String = $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return temp == "" ? nil : temp
        }
        self.init(title: title, tag: tags, url: url, imageData: imageData)
    }
    
    //returns a String of comma seperated values from the input string
    func toStringTag(var tag: [String]) -> String{
        if (tag.count < 0){
            let first: String = tag.removeFirst()
            let memes = tag.reduce(first, combine: { " \($0), \($1)" })
        
            return memes
        }else{
            return ""
        }
    }
    //returns an array from a string of comma seperated values
    func stringToArray( tag: String) ->[String] {
         let tags: [String] = tag.componentsSeparatedByString(",").flatMap{
            let temp: String = $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return temp == "" ? nil : temp
        }
        return tags
    }
}