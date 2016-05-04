//
//  PhotoViewController.swift
//  MyPhotos
//
//  Created by s5014219 on 4/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController{
    //the photo to display
    var photo: Photo?
    
    //the image to be displayed
    @IBOutlet var imageDisplay: UIImageView!
    
    //action for right swipe
    @IBAction func swipeRight(sender: AnyObject) {
    }
    //action for left swipe
    @IBAction func swipeLeft(sender: AnyObject) {
    }
    
    //when the view loads the image from photo is extracted and displayed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}