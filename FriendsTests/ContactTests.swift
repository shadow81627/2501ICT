//
//  ContactTests.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import XCTest
import UIKit
@testable import Friends

class ContactTests: XCTestCase {
    
    let someAddress = "9 Fake st"
    let someFirstName = "Peter"
    let someLastName = "File"
    let someImageData = ""
    let someURL = "https://www.google.com.au/"
    let someImageURL = "http://epaper2.mid-day.com/images/no_image_thumb.gif"
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //test to see if the initialiser for the address in Contact class works
    func testAddress() {
        let addressToTest = "7 Fake st"
        let contact = Contact(address: addressToTest, firstName: someFirstName, lastName: someLastName, stringURL: someImageURL)
        XCTAssertEqual(contact.address, addressToTest)
    }
    
    //test to see if the initialiser for the firstName in Contact class works
    func testfirstName() {
        let firstNameToTest = "Ben"
        let contact = Contact(address: someAddress, firstName: firstNameToTest, lastName: someLastName, stringURL: someImageURL)
        XCTAssertEqual(contact.address, firstNameToTest)
    }
    
    //test to see if the initialiser for the lastName in Contact class works
    func testLastName() {
        let lastNameToTest = "John"
        let contact = Contact(address: someAddress, firstName: someFirstName, lastName: lastNameToTest, stringURL: someImageURL)
        XCTAssertEqual(contact.address, lastNameToTest)
    }
    
    //test to see if the initialiser for the stringURL in Contact class works
    func testfirstName() {
        let firstNameToTest = "http://epaper2.mid-day.com/images/no_image_thumb.gif"
        let contact = Contact(address: someAddress, firstName: firstNameToTest, lastName: someLastName, stringURL: someImageURL)
        XCTAssertEqual(contact.address, firstNameToTest)
    }

}
