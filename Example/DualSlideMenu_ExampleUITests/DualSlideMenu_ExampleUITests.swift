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
    var expect: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        controller = DualSlideMenuViewController(mainViewController: UIViewController(), leftMenuViewController: UIViewController(), rightMenuViewController: UIViewController())
        controller.delegate = self
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLeftMenuSwipe() {
        dispatchAsyncExpectation("right", type: State.Left, instance: controller)
    }
    
    func testRightMenuSwipe() {
        dispatchAsyncExpectation("left", type: State.Right, instance: controller)
    }
    
    func testSwipeHome() {
        controller.toLeft()
        dispatchAsyncExpectation("left", type: State.Main, instance: controller)
        
        controller.toRight()
        dispatchAsyncExpectation("right", type: State.Main, instance: controller)
    }
    
    func testInstantSlide() {
        controller.toLeft()
        XCTAssertEqual(State.Left, controller.currentState)
        controller.toMain()
        XCTAssertEqual(State.Main, controller.currentState)
        controller.toRight()
        XCTAssertEqual(State.Right, controller.currentState)
        controller.toLeft()
        XCTAssertEqual(State.Left, controller.currentState)
    }
    
    func testCollapseAll() {
        controller.toLeft()
        dispatchAsyncExpectation("right", type: State.Main, instance: controller)
        
        controller.toRight()
        dispatchAsyncExpectation("left", type: State.Main, instance: controller)
    }
    
    func testJustLeftMenu() {
        let leftOnly = DualSlideMenuViewController(mainViewController: UIViewController(), leftMenuViewController: UIViewController())
        leftOnly.delegate = self
        dispatchAsyncExpectation("right", type: State.Left, instance: leftOnly)
        
        dispatchAsyncExpectation("left", type: State.Main, instance: leftOnly)
        
        leftOnly.toggle("left")
        XCTAssertEqual(State.Main, leftOnly.currentState)
        
        leftOnly.toRight()
        XCTAssertEqual(State.Main, leftOnly.currentState)
    }
    
    func testJustRightMenu() {
        let rightOnly = DualSlideMenuViewController(mainViewController: UIViewController(), rightMenuViewController: UIViewController())
       rightOnly.delegate = self
        dispatchAsyncExpectation("left", type: State.Right, instance: rightOnly)
        
        dispatchAsyncExpectation("right", type: State.Main, instance: rightOnly)
        
        rightOnly.toggle("right")
        XCTAssertEqual(State.Main, rightOnly.currentState)
        
        rightOnly.toLeft()
        XCTAssertEqual(State.Main, rightOnly.currentState)
        
    }
    
    
    private func dispatchAsyncExpectation(direction: String, type: State, instance: DualSlideMenuViewController) {
        expect = expectationWithDescription("Waiting for asynchronous animation to finish")
        instance.toggle(direction)
        waitForExpectationsWithTimeout(1) { _ in
            print("comparing \(type) to \(instance.currentState)")
            XCTAssertEqual(type, instance.currentState)
        }
        
    }
}

extension DualSlideMenu_ExampleUITests: DualSlideMenuViewControllerDelegate {
    
    func didChangeView() {
        expect?.fulfill()
        print("expectation has been fulfilled")
    }
}