//
//  ViewController.swift
//  MyPhotos
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

//the delegate for handling actions with the master view
protocol DetailViewControllerDelegate {
    func update(vc: DetailViewController)
}

class DetailViewController: UIViewController {
    
    //the phot to display
    var photo: Photo?
    var delegate: DetailViewControllerDelegate?
    var flag = true
    
    //title tag and url textFields
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var tagField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    //image view
    @IBOutlet weak var imageDisplay: UIImageView!

    //when the view loads the image from photo is extracted and displayed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let title = photo?.title {
            titleField.text = title
        }
        tagField.text = photo!.toStringTag()
        if let url = photo?.url {
            urlField.text = url
        }
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }
    
    //when the page closes the data from the text fields is added back into the photo
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if(titleField.text != nil) {
            photo?.title = titleField.text
        }
        //the tag text field is a series of comma seperated values that get split into an array
        if (tagField.text != nil) {
            photo?.tag = photo?.stringToArray(tagField.text!)
        }
        if(urlField.text != nil) {
            photo?.url = urlField.text!
        }
        delegate?.update(self)
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

