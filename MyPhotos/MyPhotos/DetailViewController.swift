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
    func binPressed(vc: DetailViewController)
}

class DetailViewController: UIViewController {
    
    //the photo to display
    var photo: Photo!
    var delegate: DetailViewControllerDelegate?
    
    //title tag and url textFields
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var tagField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    //image view
    @IBOutlet weak var imageDisplay: UIImageView!
    //Button for bin
    @IBOutlet weak var binButton: UIBarButtonItem!

    //when the view loads the image from photo is extracted and displayed
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let title = photo?.title {
            titleField.text = title
        }
        if var tag = photo.tag {
            if (tag.count > 0){
                let first: String = tag.removeFirst()
                tagField.text = tag.reduce(first, combine: { " \($0), \($1)" })
            }
        }
        if let url = photo?.url {
            urlField.text = url
        }
        displayImage()
        
        //the observer for if the image data changes
        photo?.addObserver(self, forKeyPath: "imageData", options: .New, context: nil)
    }
    
    //makes the keyboard disappear when you hit return
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        updateUrl()
        delegate?.update(self)
        textField.resignFirstResponder()
        return true
    }
    
    //when the delete button is pressed an action sheet apears to confirm deleting the photo
    @IBAction func binButton(sender: AnyObject) {
        if (titleField.text != nil && titleField.text != "") && (urlField.text != nil && urlField.text != ""){

            let optionMenu = UIAlertController(title: "Confirm Delete", message: "Do you really want to delete \(titleField.text!)", preferredStyle: .ActionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                self.delegate?.binPressed(self)
                self.delegate?.update(self)
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
          
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
            })
            
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    //when the page closes the data from the text fields is added back into the photo
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        if(titleField.text != nil) {
            photo?.title = titleField.text!
        }
        //the tag text field is a series of comma seperated values that get split into an array
        if (tagField.text != nil) {
            photo?.tag = tagField.text!.componentsSeparatedByString(",").flatMap {
                let temp: String = $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                return temp == "" ? nil : temp
            }
        }
        updateUrl()
        delegate?.update(self)
        //removes the resign observer
        photo!.removeObserver(self, forKeyPath: "imageData")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //sets the image display to display the photo image data
    func displayImage(){
        if let imageData = photo?.imageData {
            self.imageDisplay.image = UIImage(data: imageData)
        }
    }
    
    //updates the photos url with the data in the url field
    func updateUrl(){
        if(urlField.text != nil && urlField.text != "") {
            if (urlField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).rangeOfCharacterFromSet(NSCharacterSet.whitespaceCharacterSet()) == nil){
                photo?.url = urlField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            }
        }
    }
    
    //updates the image data if it has changed
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard keyPath == "imageData" else{
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        displayImage()
    }
    
    
}

