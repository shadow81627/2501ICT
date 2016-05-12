//
//  TimeLineEntry.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

//
class TimelineEntry {
    
    var image: NSData?
    var siteData: NSData
    var text: String
    
    init(image: NSData?, siteData: NSData, text: String){
        self.image = image
        self.siteData = siteData
        self.text = text
    }
}