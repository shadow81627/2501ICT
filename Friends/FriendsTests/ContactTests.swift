//
//  ContactTests.swift
//  Friends
//
//  Created by s5014219 on 12/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import XCTest
@testable import Friends

class ContactTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    //test to see if the initialiser for the address in Contact class works
    func testAddress() {
        let addressToTest = "7 Fake st"
        let contact = Contact(address: addressToTest, firstName: "someFirstName", lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        XCTAssertEqual(contact.address, addressToTest)
    }
    
    //test to see if the initialiser for the firstName in Contact class works
    func testfirstName() {
        let firstNameToTest = "Ben"
        let contact = Contact(address: "someAddress", firstName: firstNameToTest, lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        XCTAssertEqual(contact.firstName, firstNameToTest)
    }
    
    //test to see if the initialiser for the lastName in Contact class works
    func testLastName() {
        let lastNameToTest = "John"
        let contact = Contact(address: "someAddress", firstName: "someFirstName", lastName: lastNameToTest, imageURL:"http://epaper2.mid-day.com/images/no_image_thumb.gif")
        XCTAssertEqual(contact.lastName, lastNameToTest)
    }
   
    //test to see if the initialiser for the imageURL in Contact class works
    func testImageURL() {
        let stringURLToTest = "http://epaper2.mid-day.com/images/no_image_thumb.gif"
        let contact = Contact(address: "someAddress", firstName: "someFirstName", lastName: "someLastName", imageURL: stringURLToTest)
        XCTAssertEqual(contact.imageURL, stringURLToTest)
    }
    
    //test to see if the initialiser for the accounts list in Contact class works
    func testAccounts() {
        let contact = Contact(address: "someAddress", firstName: "someFirstName", lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        let account0 = SocialMediaAccount(identifier: "jim@facebook.com", type: "Facebook", contact: contact)
        let account1 = SocialMediaAccount(identifier: "jim@twitter.com", type: "Twitter", contact: contact)
        var accountsToTest = [SocialMediaAccount]()
        accountsToTest.append(account0)
        accountsToTest.append(account1)
        contact.accounts = accountsToTest
        XCTAssertEqual(contact.accounts!, accountsToTest)
    }
    
    //test if propertyList works
    func testPropertyList(){
        let testContact = Contact(address: "someAddress", firstName: "someFirstName", lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        let testPropertyList = testContact.propertyList()
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = documentsDirectory.stringByAppendingPathComponent("test.plist")
        testPropertyList.writeToFile(fileName, atomically: true)
        let optionalArray = NSDictionary(contentsOfFile: fileName);
        let testPhoto2 = Contact(propertyList: optionalArray!)
        XCTAssertEqual(testContact.propertyList(), testPhoto2.propertyList());
    }
    
   
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}