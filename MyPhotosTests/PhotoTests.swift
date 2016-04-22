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
    //tests to see if the title works
    func testTitle() {
        let titleToTest = "Nice Photo"
        let photo = Photo(title: titleToTest, url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png")
        XCTAssertEqual(photo.title, titleToTest)
    }
    
    //tests to see if the tags works
    func testTag() {
        let tagToTest = ["Memes"]
        let photo = Photo(tag: tagToTest, url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png")
        XCTAssertEqual(photo.tag!, tagToTest)
    }
    
    //tests to see if the tags works
    func testUrl() {
        let urlToTest = "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"
        let photo = Photo(url: urlToTest)
        XCTAssertEqual(photo.url, urlToTest)
    }
    
    //tests to see if the tags to string works
    func testToStringTag(){
        let tagToTest = "stuff, and, more, things"
        let urlToTest = "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"
        let photo = Photo(tag: tagToTest, url: urlToTest)
        XCTAssertEqual(photo.tag![0], "stuff")
        XCTAssertEqual(photo.tag![1], "and")
        
    }
}
