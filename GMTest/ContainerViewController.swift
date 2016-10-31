//
//  ContainerViewController.swift
//  GMTest
//
//  according to this lesson: https://www.raywenderlich.com/78568/create-slide-out-navigation-panel-swift
//  Created by Alex Dontsov on 31.10.16.
//  Copyright © 2016 Kinect.Pro. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case closed
    case expanded
}

class ContainerViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var centerViewController: MapsViewController!
    
    var currentState: SlideOutState = .closed {
        didSet {
            showShadowForCenterViewController(shouldShowShadow: currentState == .expanded)
        }
    }
    var menuViewController: MenuViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    let animationDuration : Double = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerViewController = UIStoryboard.mapsViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
        addMenuViewController()
    }
    
}

// MARK: CenterViewController delegate

extension ContainerViewController: MapsViewControllerDelegate {
    
    func toggleMenu() {
        let notAlreadyExpanded = (currentState != .expanded)
        animateMenu(shouldExpand: notAlreadyExpanded)
    }
    
    
    func addMenuViewController() {
        menuViewController = UIStoryboard.menuViewController()
        menuViewController!.menuItems = City.availableCities()
        view.insertSubview(menuViewController!.view, at: 0)

        menuViewController!.delegate = centerViewController
        addChildViewController(menuViewController!)
        
        menuViewController!.didMove(toParentViewController: self)

    }
    
    
    func animateMenu(shouldExpand: Bool) {
        
        if (shouldExpand) {
            currentState = .expanded
            animateCenterPanelXPosition(targetPosition: (centerNavigationController.view.frame).width - centerPanelExpandedOffset)
        } else {
            currentState = .closed
            animateCenterPanelXPosition(targetPosition: 0)
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
        })
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    class func menuViewController() -> MenuViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    }
    
    class func mapsViewController() -> MapsViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "MapsViewController") as! MapsViewController
    }
    
}
