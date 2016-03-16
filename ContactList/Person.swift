//
//  Person.swift
//  Personal
//
//  Created by s5014219 on 9/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation
/**
* THe person class
*/
class Person {
    var firstName: String
    var lastName: String
    var yearOfBirth: Int?
    var age : Int{
        get{
            let currentDate = NSDate(),
            calendar = NSCalendar.currentCalendar(),
            currentYear = calendar.component(.Year, fromDate: currentDate)
            return currentYear - yearOfBirth!
        }
    }
    var middleName: String?
    
    /**
    * The initator for the Person class 
    */
    init(firstName: String, lastName: String, yearOfBirth: Int?, middleName: String? = nil){
        self.firstName = firstName
        self.lastName = lastName
        self.yearOfBirth = yearOfBirth
        self.middleName = middleName
    }
    /**
    * The to string function
    */
    func fullName() -> String {
        if middleName != nil {
            return firstName + middleName! + lastName + "\(age)"
        }else {
            return firstName + lastName + "\(age)"
        }
    }
}