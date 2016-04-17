//
//  AppDelegate.swift
//  DualSlideMenu
//
//  Created by Vincent Le on 03/23/2016.
//  Copyright (c) 2016 Vincent Le. All rights reserved.
//

import UIKit
import DualSlideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard?
    var controller: DualSlideMenuViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        storyboard = UIStoryboard(name: "Main", bundle: nil)

        
        let leftView = storyboard?.instantiateViewControllerWithIdentifier("LeftMenuController") as! LeftViewController
        let rightView = storyboard?.instantiateViewControllerWithIdentifier("RightMenuController")
        let mainView = storyboard?.instantiateViewControllerWithIdentifier("MainController") as! ExampleViewController
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 20, mainView.view.frame.size.width, 44))
        let navigationItem = UINavigationItem()
        let menuButton = UIBarButtonItem(image: UIImage(named: "hamburger"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AppDelegate.menuButtonTapped(_:)))
        let composeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(AppDelegate.composeButtonTapped(_:)))
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItem = composeButton
        navigationBar.items = [navigationItem]
        mainView.view.addSubview(navigationBar)
        
        controller = DualSlideMenuViewController(mainViewController: mainView, leftMenuViewController: leftView, rightMenuViewController: rightView!)
        controller?.delegate = mainView
        controller!.leftSideOffset = 100
        controller!.rightSideOffset = 20
        controller!.addSwipeGestureInSide(rightView!, direction: .Right)
        controller!.addSwipeGestureInSide(leftView, direction: .Left)
        leftView.controller = controller
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        return true
    }
    
    func menuButtonTapped(sender: UIBarButtonItem){
        controller?.toggle("right")
    }
    func composeButtonTapped(sender: UIBarButtonItem){
        controller?.toggle("left")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

