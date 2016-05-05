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
            print(photo!.title)
        }
    }
    //action for left swipe
    @IBAction func swipeLeft(sender: AnyObject) {
        delegate?.nextPhoto(self)
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
            print(photo!.title)
        }
        print(photo!.title)
    }
    
    //when the view loads the image from photo is extracted and displayed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}