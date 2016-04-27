//
//  PhotoListTests.swift
//  MyPhotos
//
//  Created by s5014219 on 28/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import XCTest
@testable import MyPhotos

class PhotoListTests: XCTestCase {
    
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
    
            //tests to see if the photo array lets you insert
            func testArrayInsert(){
                let urlToTest = "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"
                let photo = Photo(url: urlToTest)
                let photoEmpty = Photo(url: urlToTest)
                let photoList = PhotoList()
                photoList.entries.insert(photo, atIndex: 0)
                //photoLIst.entires.insert(photoEmpty, Index: 1)
                XCTAssertEqual(photoList.entries[0].url, photo.url)
                //XCTAssertEqual(photoList.entries[1].url, photoEmpty.url)
            }
            
            //tests to see if the photo array lets you insert
            func testArrayInsertMiddle(){
                /*let urlToTest = "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"
                let photo = Photo(url: urlToTest)
                let photoList = PhotoList()
                photoList.entries.insert(photo, atIndex: 3)
                XCTAssertEqual(photoList.entries[3].url, photo.url)*/
            }

            //tests to see if the photo array lets you append
            func testArrayAppend(){
                let urlToTest = "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png"
                let photo = Photo(url: urlToTest)
                let photoList = PhotoList()
                photoList.entries.append(photo)
                XCTAssertEqual(photoList.entries[0].url, photo.url)
            }
        }
    }
}
