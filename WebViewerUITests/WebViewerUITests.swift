//
//  WebViewerUITests.swift
//  WebViewerUITests
//
//  Created by s5014219 on 11/05/2016.
//  Copyright © 2016 s5014219. All rights reserved.
//

import XCTest

class WebViewerUITests: XCTestCase {
        
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
    
    //test to see if the url https://www.google.com.au/ will be loaded
    func testUrl() {
        let app = XCUIApplication()
        let textField = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.TextField).element
        textField.tap()
        textField.typeText("https://www.google.com.au/")
        app.buttons["Return"].tap()
    }
    
    //test to see if no url is handled
    func testNoUrl() {
        let app = XCUIApplication()
        let textField = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.TextField).element
        textField.tap()
        app.buttons["Return"].tap()
        
    }
    
}
