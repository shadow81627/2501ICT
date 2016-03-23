//
//  Person.swift
//  Personal
//
//  Created by s5014219 on 9/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation


// The person class
class Person {
    
    var firstName: String
    var lastName: String
    
    // The date of birth of a person is used to derive the age of a person using the current date 
    var yearOfBirth: Int? {
         get{
            return self.yearOfBirth
        }
        set(age){
            let currentDate = NSDate(),
            calendar = NSCalendar.currentCalendar(),
            currentYear = calendar.component(.Year, fromDate: currentDate)
            self.yearOfBirth = currentYear - age!
        }
    }
    // The age of a person, derived from the date of birth of a person
    var age : Int{
        get{
            let currentDate = NSDate(),
            calendar = NSCalendar.currentCalendar(),
            currentYear = calendar.component(.Year, fromDate: currentDate)
            return currentYear - yearOfBirth!
        }
        set(age){
            yearOfBirth = age
        }
    }
    // The middle name of a person
    var middleName: String?
    
    // The initator for the Person class
    init(firstName: String, lastName: String, yearOfBirth: Int? = nil, middleName: String? = nil){
        self.firstName = firstName
        self.lastName = lastName
        self.yearOfBirth = yearOfBirth
        self.middleName = middleName
    }
    
    // Secondary Initaliser for the Person class
    convenience init(firstName: String, lastName: String, age: Int, middleName: String? = nil){
        self.init(firstName: firstName, lastName: lastName, yearOfBirth: age, middleName: middleName)

    }
    
    // The to string function
    func fullName() -> String {
        if middleName != nil {
            return firstName + middleName! + lastName + "\(age)"
        }else {
            return firstName + lastName + "\(age)"
        }
    }
}