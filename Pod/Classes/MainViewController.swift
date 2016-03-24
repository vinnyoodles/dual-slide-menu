//
//  MainViewController.swift
//  Pods
//
//  Created by Vincent Le on 3/23/16.
//
//

import UIKit

protocol MainViewControllerDelegate {
    func toggle(swipeDirection: String)
    func closeBothMenu()
}
class MainViewController: UIViewController {
    
    //The connection between main vc and the container vc
    var delegate: MainViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        //add swipe recognizers
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            print("left swipe")
            delegate?.toggle("left")
        }
        else if (sender.direction == .Right){
            print("right swipe")
            delegate?.toggle("right")
        }
    }
}
