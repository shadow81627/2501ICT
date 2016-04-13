//
//  DetailViewController.swift
//  ContactList
//
//  Created by s5014219 on 16/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

//
protocol DetailViewControllerDelegate {
    func submitPress(vc: DetailViewController)
}

class DetailViewController: UIViewController, UITextFieldDelegate{
    
    var delegate: DetailViewControllerDelegate?
    var person: ContactListEntry?

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var firstNameField: UITextField!

    @IBOutlet weak var middleNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var yearOfBirthField: UITextField!

    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
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
    
    @IBAction func submitButton(sender: AnyObject) {
        
        delegate?.submitPress(self)
        
    }
    
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        
    }


}

