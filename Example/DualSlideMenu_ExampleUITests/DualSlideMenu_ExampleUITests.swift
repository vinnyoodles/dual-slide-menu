//
//  DualSlideMenu_ExampleUITests.swift
//  DualSlideMenu_ExampleUITests
//
//  Created by Vincent Le on 5/13/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import DualSlideMenu

class DualSlideMenu_ExampleUITests: XCTestCase {
    
    var controller: DualSlideMenuViewController!
    var left: UIViewController!
    var right: UIViewController!
    var main: UIViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        left = storyboard.instantiateViewControllerWithIdentifier("LeftMenuController")
        right = storyboard.instantiateViewControllerWithIdentifier("RightMenuController")
        main = storyboard.instantiateViewControllerWithIdentifier("MainController")
        controller = DualSlideMenuViewController(mainViewController: main, leftMenuViewController: left, rightMenuViewController: right)
        
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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
