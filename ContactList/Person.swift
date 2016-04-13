//
//  Person.swift
//  Personal
//
//  Created by s5014219 on 9/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation


// The person class used to store the detials of a person such as name and age
class Person {
    
    //the first name of a person
    var firstName: String
    //the last name of a person
    var lastName: String
    
    // The date of birth of a person, can be used to derive the age of a person
    var yearOfBirth: Int?
    // The age of a person, derived from the date of birth of a person using the current date
    var age : Int{
        get{
            let currentDate = NSDate(),
            calendar = NSCalendar.currentCalendar(),
            currentYear = calendar.component(.Year, fromDate: currentDate)
            return currentYear - yearOfBirth!
        }
        set(age){
                let currentDate = NSDate(),
                calendar = NSCalendar.currentCalendar(),
                currentYear = calendar.component(.Year, fromDate: currentDate)
                yearOfBirth = currentYear - age
        }
    }
    // The middle name of a person
    var middleName: String?
    
    // The initator for the Person class that uses yearOfBirth to calculate age
    init(firstName: String, lastName: String, yearOfBirth: Int? = nil, middleName: String? = nil){
        self.firstName = firstName
        self.lastName = lastName
        self.yearOfBirth = yearOfBirth
        self.middleName = middleName
    }
    
    // Secondary Initaliser for the Person class that takes age as an imput instead of yearOfBirth
    convenience init(firstName: String, lastName: String, age: Int, middleName: String? = nil){
        self.init(firstName: firstName, lastName: lastName, yearOfBirth: age, middleName: middleName)

    }
    
    // The fullName function returns the full name and age of a person
    func fullName() -> String {
        if middleName != nil {
            return firstName + " " + middleName! + " " + lastName + " " + "\(age)"
        }else {
            return firstName + " " + lastName + " " + "\(age)"
        }
    }
}