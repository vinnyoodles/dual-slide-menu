//
//  DualSlideMenuViewController.swift
//  Pods
//
//  Created by Vincent Le on 3/24/16.
//
//

import UIKit

enum State {
    case Left
    case Right
    case Main
}

class DualSlideMenuViewController: UIViewController, MainViewControllerDelegate {
    
    //Create variables that will be used 
    var mainStoryboard: UIStoryboard!
    var mainView: MainViewController!
    var navigation: UINavigationController!
    var rightMenu: SideMenuViewController?
    var leftMenu: SideMenuViewController?
    var currentState: State = .Main
    var sideViewOffset: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        //First, instantiate the view controllers that will appear first
        mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        mainView = mainStoryboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
//        rightMenu = mainStoryboard.instantiateViewControllerWithIdentifier("RightMenuController") as! SideMenuViewController
//        leftMenu = mainStoryboard.instantiateViewControllerWithIdentifier("LeftMenuController") as! SideMenuViewController
        
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
        ex. "left" or "right" where swiping from left to right is a "right" swipe
     */
    func toggle(swipeDirection: String) {
        switch currentState{
        case .Left :
            //Swipe left to close left panel
            if (swipeDirection == "left") {
                moveToView(false, type: .Left)
            }
            break
        case .Right :
            //Swipe right to close right panel
            if (swipeDirection == "right") {
                moveToView(false, type: .Right)
            }
            break
        case .Main :
            //Swipe left to open right panel
            if (swipeDirection == "left") {
                addSideMenuViewController(.Right)
                moveToView(true, type: .Right)
            }
            //Swipe right to open left panel
            else if (swipeDirection == "right") {
                addSideMenuViewController(.Left)
                moveToView(true, type: .Left)
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
    
    func addSideMenuViewController(type: State) {
        if (type == .Right && rightMenu == nil) {
            rightMenu = mainStoryboard.instantiateViewControllerWithIdentifier("RightMenuController") as? SideMenuViewController
            rightMenu!.type = .Right
            addChildViewController(rightMenu!)
        }
        else if (type == .Left && leftMenu == nil) {
            leftMenu = mainStoryboard.instantiateViewControllerWithIdentifier("LeftMenuController") as? SideMenuViewController
            leftMenu!.type = .Left
            addChildViewController(leftMenu!)
        }
    }
    
    /**
     Navigate to left or right panel
     
     - parameter open: to show the side view or to show the main view
     - parameter type: the type of view that is currently being displayed
     */
    func moveToView(open: Bool, type: State){
        if (open) {
            currentState = type
            //Calculate the amount of distance the main view needs to move
            //Use ternary operator to find direction
            let mainViewDisplacement = type == .Left ?
                CGRectGetWidth(navigation.view.frame) - sideViewOffset :
                -CGRectGetWidth(navigation.view.frame) + sideViewOffset
            moveMainViewBy(mainViewDisplacement)
        }
        else {
            //Move back to main view
            moveMainViewBy(0) { completion in
                if (type == .Left) {
                    self.leftMenu!.view.removeFromSuperview()
                    self.leftMenu = nil
                }
                else if (type == .Right) {
                    self.rightMenu!.view.removeFromSuperview()
                    self.rightMenu = nil
                }
                self.currentState = .Main
            }
            
        }
        
    }
    /**
     Controls the animation of sliding a view on or off where the main view
     is the view that is being moved in order to show the side views
     - parameter xDisplacement: The slide value and direction
     - parameter completion:   The completion handler for asynchronous calls
     */
    func moveMainViewBy(xDisplacement: CGFloat, completion: ((Bool) -> Void)! = nil) {
        //Animate with a spring damping coefficient of 0.8
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.navigation.view.frame.origin.x = xDisplacement
            }, completion: completion)
    }
}
