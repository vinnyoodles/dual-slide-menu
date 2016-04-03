//
//  DualSlideMenuViewController.swift
//  Pods
//
//  Created by Vincent Le on 3/24/16.
//
//

import UIKit

public enum State {
    case Left
    case Right
    case Main
}
public class DualSlideMenuViewController: UIViewController {
    
    //Create variables that will be used 
    public var mainView: UIViewController!
    public var navigation: UINavigationController!
    public var currentState: State = .Main
    public var mainStoryboard: UIStoryboard!
    public var rightMenu: UIViewController!
    public var leftMenu: UIViewController!
    public var sideViewOffset: CGFloat = 150
    
    public convenience init(mainViewController: UIViewController, leftMenuViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.init()
        mainView = mainViewController
        leftMenu = leftMenuViewController
        rightMenu = rightMenuViewController
        
        addSwipeGestures(mainView)
        view.insertSubview(mainView.view, atIndex: 0)
        view.insertSubview(rightMenu.view, belowSubview: mainView.view)
        view.insertSubview(leftMenu.view, belowSubview: rightMenu.view)
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    /**
     called on initialization
     adds left and right swipe recognizers
     
     - parameter mainView: the view that will contain the gestures
     */
    func addSwipeGestures(mainView: UIViewController) {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        mainView.view.addGestureRecognizer(leftSwipe)
        mainView.view.addGestureRecognizer(rightSwipe)
    }
    /**
     called when the user makes a swipe
     
     - parameter sender: the sender
     */
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            toggle("left")
        }
        else if (sender.direction == .Right){
            toggle("right")
        }
    }
    
    /**
     Main toggle function that controls navigation of side menu
     
     - parameter swipeDirection: the direction of the swipe
        ex. "left" or "right" where swiping from left to right is a "right" swipe
     */
    public func toggle(swipeDirection: String) {
        switch currentState{
        case .Main :
            //Swipe left to open right panel
            if (swipeDirection == "left") {
                moveToView(true, type: .Right)
                swapPanels(.Right)
            }
            //Swipe right to open left panel
            else if (swipeDirection == "right") {
                moveToView(true, type: .Left)
                swapPanels(.Left)
            }
            break
        case .Left :
            //Swipe left to close left panel
            if (swipeDirection == "left") {
                moveToView(false, type: .Left)
            } else {
                collapseAll()
            }
            break
        case .Right :
            //Swipe right to close right panel
            if (swipeDirection == "right") {
                moveToView(false, type: .Right)
            } else {
                collapseAll()
            }
            break
        }
    }
    func collapseAll() {
        if currentState == .Left {
            moveToView(false, type: .Left)
        } else if currentState == .Right {
            moveToView(false, type: .Right)
        }
    }
    /**
     Swap side panels positions
        example places right panel behind left panel
     
     - parameter type: the panel that will be on top
     */
    func swapPanels(type: State) {
        if (type == .Right){
            leftMenu.view.removeFromSuperview()
            view.insertSubview(leftMenu.view, belowSubview: rightMenu.view)
            
        }
        else if (type == .Left) {
            rightMenu.view.removeFromSuperview()
            view.insertSubview(rightMenu.view, belowSubview: leftMenu.view)
 
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
            var displacement: CGFloat = 0
            //Calculate the amount of distance the main view needs to move
            if (type == .Left) {
                displacement = CGRectGetWidth(mainView.view.frame) - sideViewOffset
            }
            else if (type == .Right) {
                displacement = sideViewOffset - CGRectGetWidth(mainView.view.frame)
            }
            moveMainViewBy(displacement)
        }
        else {
            //Move back to main view
            moveMainViewBy(0) { completion in
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
            self.mainView.view.frame.origin.x = xDisplacement
        }, completion: completion)
    }
}
