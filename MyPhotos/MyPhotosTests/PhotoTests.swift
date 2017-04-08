//
//  MyPhotosTests.swift
//  MyPhotosTests
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import XCTest
@testable import MyPhotos

class PhotoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            
        }
    }
    
    func testPropertyList() {
        let d = ["title": 1, "tag": 2, "url": 3, ];
        print(d)
    }
    
    //tests to see if the title works
    func testTitle() {
        let titleToTest = "Nice Photo"
        let photo = Photo(title: titleToTest, url: "0");
        XCTAssertEqual(photo.title, titleToTest)
    }
    
    //tests to see if the tags Array works
    func testTag() {
        let tagToTest = ["stuff", "more stuff"]
        let photo = Photo(title: "", tag: tagToTest, url: "0")
        XCTAssertEqual(photo.tag!, tagToTest)
    }
    
    //tests to see if the url works
    func testUrl() {
        let urlToTest = "0";
        let photo = Photo(title: "", url: urlToTest);
        XCTAssertEqual(photo.url, urlToTest);
    }
    
    //test if propertyList works
    func testpropertyList(){
        let testPhoto = Photo(title: "0", tag: ["1", "2"], url: "3")
        let testPropertyList = testPhoto.propertyList()
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = documentsDirectory.stringByAppendingPathComponent("test.plist")
        testPropertyList.writeToFile(fileName, atomically: true)
        let optionalArray = NSDictionary(contentsOfFile: fileName);
        let testPhoto2 = Photo(propertyList: optionalArray!)
        XCTAssertEqual(testPhoto.propertyList(), testPhoto2.propertyList());
    }
    
    //test if propertyList hands no tags
    func testpropertyListNilTags(){
        let testPhoto = Photo(title: "0", url: "3")
        let testPropertyList = testPhoto.propertyList()
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let fileName = documentsDirectory.stringByAppendingPathComponent("test.plist")
        testPropertyList.writeToFile(fileName, atomically: true)
        let optionalArray = NSDictionary(contentsOfFile: fileName);
        let testPhoto2 = Photo(propertyList: optionalArray!)
        XCTAssertEqual(testPhoto.propertyList(), testPhoto2.propertyList());
    }
}
