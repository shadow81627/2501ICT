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
    var age : Int
    var middleName: String?
    /**
    * The initator for the Person class 
    */
    init(firstName: String, lastName: String, age: Int, middleName: String? = nil){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
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