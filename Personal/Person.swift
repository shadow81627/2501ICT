//
//  Person.swift
//  Personal
//
//  Created by s5014219 on 9/03/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import Foundation

class Person {
    var firstName: String
    var lastName: String
    var middleName: String?
    
    init(firstName: String, lastName: String, age: Int, middleName: String? = nil){
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
    }
    
    func fullName() -> String {
        if middleName != nil {
            return firstName + middleName! + lastName
        }else {
            return firstName + lastName
        }
    }
}