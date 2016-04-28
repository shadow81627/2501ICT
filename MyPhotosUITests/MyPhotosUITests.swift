//
//  MyPhotosUITests.swift
//  MyPhotosUITests
//
//  Created by s5014219 on 20/04/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import XCTest
@testable import MyPhotos

class MyPhotosUITests: XCTestCase {
        
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
    
    func wait(delay: NSTimeInterval = 2){
        let runLoop = NSRunLoop.mainRunLoop()
        let someFutureDate = NSDate(timeIntervalSinceNow: delay)
        runLoop.runUntilDate(someFutureDate)
    }
    
    //tests to see if the buttons for adding a photo work
    func testAddingEntries() {
        let app = XCUIApplication()
        app.navigationBars["Photo Collection"].buttons["Add"].tap()
        wait(10)
        app.navigationBars["Photo"].buttons["Photo Collection"].tap()
    }
    
    //tests to see if the buttons for deleteing a photo work
    func testDeleteEtries(){
        let app = XCUIApplication()
        wait(10)
        app.navigationBars["Photo"].buttons["Delete"].tap()
        wait(10)
        app.sheets["Confirm Delete"].collectionViews.buttons["Delete"].tap()
        
    }
    
    func testUpdateEntries(){        
        
    }
    
}
