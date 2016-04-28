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
    
    //tests to see if the photo array lets you insert
    func testArrayInsert(){
        let urlToTest = "0"
        let photo = Photo(url: urlToTest)
        let photoList = PhotoList()
        photoList.entries.insert(photo, atIndex: 0)
        XCTAssertEqual(photoList.entries[0].url, photo.url)
    }
    
    //tests to see if the photo array lets you insert in the middle of the array
    func testArrayInsertMiddle(){
        let urlToTest = "0"
        let photo = Photo(url: urlToTest)
        let photo1 = Photo(url: "1")
        let photo2 = Photo(url: "2")
        let photoList = PhotoList()
        //insert first photo
        var index = (photoList.entries.count)/2
        photoList.entries.insert(photo, atIndex: index)
        //insert second photo
        index = (photoList.entries.count)/2
        photoList.entries.insert(photo1, atIndex: index)
        //insert third photo into the middle of the array
        index = (photoList.entries.count)/2
        photoList.entries.insert(photo2, atIndex: index)
        //test to see if the url in the middle of the array is the same as the photo inserted into the middle
        XCTAssertEqual(photoList.entries[index].url, photo2.url)
    }
    
    
    //tests to see if the photo array lets you append
    func testArrayAppend(){
        let urlToTest = "0"
        let photo = Photo(url: urlToTest)
        let photoList = PhotoList()
        photoList.entries.append(photo)
        XCTAssertEqual(photoList.entries[0].url, photo.url)
    }
    
    //test to see if the photo list saves to file
    func testSave(){
        let photoList = PhotoList()
        let testPhoto = Photo(title: "0", tag: ["1", "2"], url: "3")
        photoList.entries.insert(testPhoto, atIndex: 0)
        XCTAssert(photoList.save())
    }
    
    //test to see if the photo list loads from file
    func testLoad(){
        let photoList = PhotoList()
        let testPhoto = Photo(title: "0", tag: ["1", "2"], url: "3")
        photoList.entries.insert(testPhoto, atIndex: 0)
        photoList.save()
        photoList.load()
        XCTAssertEqual(<#T##expression1: [T]##[T]#>, <#T##expression2: [T]##[T]#>)

    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
