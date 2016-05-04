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
    
    @IBOutlet var imageDisplay: UIImageView!
    
    //when the view loads the image from photo is extracted and displayed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "dismissFullscreenImage:")
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }

    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
    imageView.userInteractionEnabled = true
    imageView.addGestureRecognizer(tapGestureRecognizer)
}