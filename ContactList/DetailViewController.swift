//
//  DetailViewController.swift
//  ContactList
//
//  Created by s5014219 on 16/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

//the delegate for handling actions with the master view
protocol DetailViewControllerDelegate {
    func cancelPressed(vc: DetailViewController)
    func insertNewObject(vc: DetailViewController)
    func update(vc: DetailViewController)
}

class DetailViewController: UIViewController, UITextFieldDelegate{
    
    //
    var delegate: DetailViewControllerDelegate?
    //the person that will be edited or added to the contact list
    var person: ContactListEntry?
    //used to tell if update add or cancel should happen
    var update: String?

    //the text fields
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var middleNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var yearOfBirthField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
   
    //updates the textfields with the data of the selected person if there is any
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        if let firstName = person?.firstName {
            firstNameField.text = firstName
        }
        if let lastName = person?.lastName {
            lastNameField.text = lastName
        }
        if let middleName = person?.middleName {
            middleNameField.text = middleName
        }
        if let yearOfBirth = person?.yearOfBirth {
            yearOfBirthField.text = String(yearOfBirth)
        }
        if let phone = person?.phoneNumber {
            phoneField.text = String(phone)
        }
        if let address = person?.address {
            addressField.text = address
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   //the cancel button wont add or update the person
    @IBAction func cancelButton(sender: AnyObject) {
        delegate?.cancelPressed(self)
    }
    
    
    //retrives the data from the textfields and updates the contact list with this data
    override func viewWillDisappear(animated: Bool) {
        
        if (firstNameField.text != nil) {
            person?.firstName = firstNameField.text!
        }
        if (lastNameField.text != nil) {
            person?.lastName = lastNameField.text!
        }
        if (middleNameField.text != nil) {
            person?.middleName = middleNameField.text
        }
        if (yearOfBirthField.text != nil) {
            person?.yearOfBirth = Int(yearOfBirthField.text!)
        }
        if (phoneField.text != nil){
        person?.phoneNumber = phoneField.text
        }
        if (addressField.text != nil) {
            person?.address = addressField.text
        }
        
        delegate?.update(self)
    }
}

