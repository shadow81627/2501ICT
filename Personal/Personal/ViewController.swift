//
//  ViewController.swift
//  Personal
//
//  Created by s5014219 on 9/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var middleNameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet var details: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func fullDetail(sender: UIButton) {
        let firstName = firstNameField.text!,
            lastName = lastNameField.text!,
            age = Int(ageField.text!),
            middleName = middleNameField.text
        if age != nil {
            let person = Person(firstName: firstName, lastName: lastName, age: age!, middleName: middleName)
            details.text = person.fullName()
        } else {
            details.text = "Please enter age"
        }
    }
}

