//
//  PhotoViewController.swift
//  MyPhotos
//
//  Created by s5014219 on 4/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

protocol PhotoViewControllerDelegate{
    func previousPhoto(vc: PhotoViewController)
    func nextPhoto(vc: PhotoViewController)
}

class PhotoViewController: UIViewController{
    //the photo to display
    var photo: Photo?
    var delegate: PhotoViewControllerDelegate?
    
    //the image to be displayed
    @IBOutlet var imageDisplay: UIImageView!
    
    //action for right swipe
    @IBAction func swipeRight(sender: AnyObject) {
        delegate?.previousPhoto(self)
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }
    //action for left swipe
    @IBAction func swipeLeft(sender: AnyObject) {
        delegate?.nextPhoto(self)
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }
    
    //when the view loads the image from photo is extracted and displayed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
        //the observer for if the image data changes
        photo?.addObserver(self, forKeyPath: "url", options: .New, context: nil)
    }
    
    //removes the resign observer
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        //couldnt remove observer becuase apparently there isnt one to remove
        photo?.removeObserver(self, forKeyPath: "url")
    }
    
    // MARK: - Segue
    
    //when a cell is selected segue to the detail view to display details
    //when the add button is pressed segue to the detail view to creat a new Photo
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "showDetail" {
            let vc = segue.destinationViewController as! DetailViewController
            vc.photo = photo
            vc.delegate = delegate as? DetailViewControllerDelegate
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //updates the image data if it has changed
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard keyPath == "url" else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }

}