//
//  SocialMediaAccountTests.swift
//  Friends
//
//  Created by s5014219 on 13/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import XCTest
@testable import Friends

class SocialMediaAccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIdentifier() {
        let identifierToTest = ""
        let contact = Contact(address: "7 Fake st", firstName: "someFirstName", lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        let account = SocialMediaAccount(identifier: identifierToTest, type: "stuff", contact: contact)
        XCTAssertEqual(account.identifier, identifierToTest)
    }
    
    func testContact() {
        let identifierToTest = ""
        let contact = Contact(address: "7 Fake st", firstName: "someFirstName", lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        let account = SocialMediaAccount(identifier: identifierToTest, type: "stuff", contact: contact)
        XCTAssertEqual(account.identifier, identifierToTest)
    }
    
    func testType() {
        let identifierToTest = ""
        let contact = Contact(address: "7 Fake st", firstName: "someFirstName", lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        let account = SocialMediaAccount(identifier: identifierToTest, type: "stuff", contact: contact)
        XCTAssertEqual(account.identifier, identifierToTest)
    }
    
    //test if propertyList works
    func testPropertyList(){
        let contact = Contact(address: "someAddress", firstName: "someFirstName", lastName: "someLastName", imageURL: "http://epaper2.mid-day.com/images/no_image_thumb.gif")
        let accountToTest = SocialMediaAccount(identifier: "jim@facebook.com", type: "Facebook", contact: contact)
        let account1 = SocialMediaAccount(identifier: "jim@twitter.com", type: "Twitter", contact: contact)
        var accountsToTest = [SocialMediaAccount]()
        accountsToTest.append(accountToTest)
        accountsToTest.append(account1)
        contact.accounts = accountsToTest
        let testPropertyList = accountToTest.propertyList()
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = documentsDirectory.stringByAppendingPathComponent("test.plist")
        testPropertyList.writeToFile(fileName, atomically: true)
        let optionalArray = NSDictionary(contentsOfFile: fileName);
        let accountToTest2 = SocialMediaAccount(propertyList: optionalArray!)
        XCTAssertEqual(accountToTest.propertyList(), accountToTest2.propertyList());
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
