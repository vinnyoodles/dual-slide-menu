//
//  SideMenuViewController.swift
//  Pods
//
//  Created by Vincent Le on 3/23/16.
//
//

import UIKit

enum Side{
    case Left
    case Right
}
class SideMenuViewController: UIViewController {
    //initialize variables
    var type: Side = .Left//default is left, does not make a difference
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
