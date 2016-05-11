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
    var imageURL: NSURL {
        get{
            return self.imageURL
        }set(url){
            self.imageURL = url
            loadPhotoInBackground()
        }
    }
    
    //initialiser for the Contact class
    init(address: String, firstName: String, lastName: String, image: NSData? = nil, imageURL: NSURL){
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        super.init()
        self.imageURL = imageURL
    }
    
    
    //Secondary initialiser for the Contact class that takes a String for the URL
    convenience init(caddress: String, firstName: String, lastName: String, image: NSData? = nil, imageURL: String){
        self.init(address: caddress, firstName: firstName, lastName: lastName, image: image, imageURL: NSURL(string: imageURL)!)
    }
    
    // MARK: - Download
    
    //downloads the images for the collection view in the background so thatt he UI is still responsive
    // the image is set to a defual no image at the begining while the actual image is being downloaded
    //if the image could not be downlaoded then the defualt image will be displayed
    func loadPhotoInBackground(){
        //defualt image
        let image = UIImage(named: "no-image.png")!
        let photoData = UIImagePNGRepresentation(image)!
        //defualt image data
        let noPhoto = NSData(data: photoData)
        if self.image == nil {
            self.image = noPhoto
        }
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        let backgroundDownload = {
            if let data = NSData(contentsOfURL: self.imageURL){
                let mainQueue = dispatch_get_main_queue()
                dispatch_async(mainQueue, {
                    self.image = data
                })
            }else {
                print("Could not download image'\(self.imageURL)'")
                self.image = noPhoto
            }
        }
        dispatch_async(queue, backgroundDownload)
    }

}