# DualSlideMenu

[![Version](https://img.shields.io/cocoapods/v/DualSlideMenu.svg?style=flat)](http://cocoapods.org/pods/DualSlideMenu)
[![License](https://img.shields.io/cocoapods/l/DualSlideMenu.svg?style=flat)](http://cocoapods.org/pods/DualSlideMenu)
[![Platform](https://img.shields.io/cocoapods/p/DualSlideMenu.svg?style=flat)](http://cocoapods.org/pods/DualSlideMenu)

Left and right slide menu to keep your main view clutter free

##Why use this

* Declutters your main view by add more real estate to your app
* Adds simple animations to improve UX
* Lots of documentation for methods and function to improve usability
* Easy for customization
* Your app can look like Slack's, Facebook's and many of Google's apps

##Walkthrough

<img src='images/demo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first. Then, run the example project and check out the example.

## Requirements

## Installation

DualSlideMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DualSlideMenu"
```

Create a main view controller, which can be considered the home view of the app, and two other view controllers which will be the left and the right side menus. Then add an identifier for the three view controllers which will be used in the AppDelegate.

![identifier](images/identifier.png)

In your AppDelegate file, add the pod to the file 
```swift
import DualSlideMenu
```

and initialize and add the three view controllers to the container class using the identifers from above

```swift
var window: UIWindow?
var storyboard: UIStoryboard?


func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
  window = UIWindow(frame: UIScreen.mainScreen().bounds)
    storyboard = UIStoryboard(name: "Main", bundle: nil)


    let leftView = storyboard?.instantiateViewControllerWithIdentifier("LeftMenuController")
    let rightView = storyboard?.instantiateViewControllerWithIdentifier("RightMenuController")
    let mainView = storyboard?.instantiateViewControllerWithIdentifier("MainController")

    let controller = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView!, rightMenuViewController: rightView!)
    window!.rootViewController = controller
    window!.makeKeyAndVisible()
    return true
}

```

If you only want to use a certain side for a menu then initalize using the following method 

```swift
    let leftView = storyboard?.instantiateViewControllerWithIdentifier("LeftMenuController")
    let mainView = storyboard?.instantiateViewControllerWithIdentifier("MainController")

    let controller = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView!)

```

The width of display for the side menus can be changed by adding this line of code to your AppDelegate inside of the didFinishLaunchWithOptions method
The offset must be added for both left and right side menu

```swift
controller.leftSideOffset = 200
controller.rightSideOffset = 200
//200 represents the width of the main view when the side menu is present
```

If you decide to add other actions to open the menu such as a hamburger button, then just call the toggle method of DualSlideMenuViewController with the parameter of which direction the main view should move. I know its counterintuitive, but think of the parameter not as where the side view appears but where the main view is moving towards
```swift
controller.toggle('right')
//This will open the left side view and move the main view to the RIGHT (KEYWORD)
```

If you needed to return to the main view but don't want the animation just call
```swift
controller.toMain()
//This will animate to the main view with showing any actual animations
```

On the other hand, if you wanted to animate to the main view with actual animations
```swift
controller.collapseAll()
```

If you wanted to add swipe gestures in the side menus, you can now do so
```swift
controller.addSwipeGestureInSide(rightView!, direction: .Right)
controller.addSwipeGestureInSide(leftView!, direction: .Left)
```

If you need an action performed when a swipe has occured, implement the delegate method `onSwipe`

```swift
class ExampleViewController: UIViewController, DualSlideMenuViewControllerDelegate {
  func onSwipe() {
    print("did swipe")
  }
}
```

###Walkthrough of new swipe gesture recognizers
<img src='images/demo3.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Contributions
I am happy to accept any open contributions. Just fork this project, make the changes and submit a pull request.

## Author

Vincent Le, vinnyoodles@gmail.com

## License

DualSlideMenu is available under the MIT license. See the LICENSE file for more info.
