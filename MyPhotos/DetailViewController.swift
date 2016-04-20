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

}

class DetailViewController: UIViewController {
    
    //the phot to display
    var photo: Photo?
    var delegate: DetailViewControllerDelegate?
    
    //title tag and url textFields
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var tagField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    //image view
    @IBOutlet weak var imageDisplay: UIImageView!

    //when the view loads the image from photo is extracted and displayed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let imageData = photo?.imageData{
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }
    override func viewWillDisappear(animated: Bool) {
        if(titleField.text != nil) {
            photo?.title = titleField.text
        }
        if (tagField.text != nil) {
            photo?.tag = tagField.text!.componentsSeparatedByString(",").flatMap {
                let temp: String = $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                return temp == "" ? nil : temp
            }
        }
        if(urlField.text != nil) {
            //photo?.url = urlField.text
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

