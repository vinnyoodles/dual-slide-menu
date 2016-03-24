//
//  ContainerViewController.swift
//  Pods
//
//  Created by Vincent Le on 3/23/16.
//
//

import UIKit

enum state {
    case Left
    case Right
    case Main
}

class ContainerViewController: UIViewController, MainViewControllerDelegate {
    
    //Create variables that will be used 
    var mainStoryboard: UIStoryboard!
    var mainView: MainViewController!
    var navigation: UINavigationController!
    var rightMenu: SideMenuViewController?
    var leftMenu: SideMenuViewController?
    var currentState: state = .Main

    override func viewDidLoad() {
        super.viewDidLoad()
        //First, instantiate all the view controllers in the container class
        mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        mainView = mainStoryboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        rightMenu = mainStoryboard.instantiateViewControllerWithIdentifier("RightMenuController") as! SideMenuViewController
        leftMenu = mainStoryboard.instantiateViewControllerWithIdentifier("LeftMenuController") as! SideMenuViewController
        
        //Set this class as the delegate to the main view to later call the toggle menu method
        mainView.delegate = self
        
        //The main view needs to be in a navigation controller because the menu view controllers are
        //being segued through a push segue and also utilize the navigation bar
        navigation = UINavigationController(rootViewController: mainView)
        self.view.addSubview(navigation.view)
        
        //Set parent-child relationships between container and navigation controllers
        addChildViewController(navigation)
        navigation.didMoveToParentViewController(self)
    }
    
    /**
     Main toggle function that controls navigation of side menu
     
     - parameter swipeDirection: the direction of the swipe
        ex. "left" or "right"
     */
    func toggle(swipeDirection: String) {
        switch currentState{
        case .Left :
            if (swipeDirection == "left") {
                animateLeftPanel(false)
            }
            break
        case .Right :
            if (swipeDirection == "right") {
                animateRightPanel(shouldExpand: false)
            }
            break
        case .Main :
            if (swipeDirection == "left") {
                addRightPanelViewController()
                animateRightPanel(shouldExpand: true)
            }
            else if (swipeDirection == "right") {
                addLeftPanelViewController()
                animateLeftPanel(true)
            }
            break
        }
    }
    /**
     Close whichever side menu that is open
     Does nothing if on the main view
     */
    func closeBothMenu() {
    }
    
    /**
     
     
     - parameter open: <#open description#>
     - parameter type: <#type description#>
     */
    func animatePanel(open: Bool, type: String){
        
    }
}
