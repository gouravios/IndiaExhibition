//
//  EXHRegistrationViewModel.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/20/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

// MARK: Note
/*
 every view controller which you want to show on the menu has to be inherited from EXHSliderSuperViewController
 And in case if you want to push a view controller from the menu and you want to add menu button you have to push the delegate object also.
 */

//

import UIKit
enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum screenNavigationSegue : String {
    
    case EXHHomeViewNavigation = "EXHHomeViewNavigation"
    case EXHFavouriteNavigation = "EXHFavouriteNavigation"
}

// Constant values
//enum screenNavigationSegue : String
//{
//
//    case EXHHomeViewNavigation = "EXHHomeViewNavigation"
//    case EXHHomeViewNavigation = "EXHAddExhibitionNavigation"
//    case EXHFavouriteNavigation = "EXHFavouriteNavigation"
//
//}

// Constant values
enum loadControllerWithIdentifier:String
{
    case EXHHomeViewContainer = "EXHHomeViewContainer"
    case EXHFavouriteController = "EXHFavouriteController"
    
}

class EXHContainerViewController: UIViewController {
    
   
    var centerNavigationController: EXHGlobalNavigationController!
    var currentState: SlideOutState = .collapsed
        {
        didSet {
            let shouldShowShadow = currentState != .collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var leftViewController:EXHLeftSliderViewController?
    let centerPanelExpandedOffset: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true
    
        _ = self.shouldPerformSegue(withIdentifier: screenNavigationSegue.EXHHomeViewNavigation.rawValue, sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    class func leftViewController() -> EXHLeftSliderViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "EXHLeftSliderViewController") as? EXHLeftSliderViewController
    }
}

extension EXHContainerViewController:SuperViewControllerDelegate
{
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
        switch (currentState) {
        case .leftPanelExpanded:
            currentState = .leftPanelExpanded
            toggleLeftPanel()
            
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func animateLeftPanel(_ shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(centerNavigationController.view.frame.width - centerPanelExpandedOffset)
        }
        else {
            animateCenterPanelXPosition(0) { finished in
                self.currentState = .collapsed
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(
        _ targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func addChildSidePanelController(_ sidePanelController: EXHLeftSliderViewController) {
        sidePanelController.delegate = self
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}
extension EXHContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch(recognizer.state) {
        case .began:
            if (currentState == .collapsed) {
                if (gestureIsDraggingFromLeftToRight) {
                    addLeftPanelViewController()
                }
                showShadowForCenterViewController(true)
            }
        case .changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translation(in: view).x
            recognizer.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if (leftViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                animateLeftPanel(hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}
extension EXHContainerViewController:SidePanelViewControllerDelegate
{
    func indexSelected(_ index:Int)
    {
        currentState = .collapsed
        self.moveToViewController(index)
        print(index)
    }
    
    func moveToViewController(_ indexPressed:Int)  {
        centerNavigationController.viewControllers.removeAll()
        switch indexPressed {
        case 1:
            _ = self.shouldPerformSegue(withIdentifier: screenNavigationSegue.EXHFavouriteNavigation.rawValue, sender: self)
            
            break
        default:
          _ =  self.shouldPerformSegue(withIdentifier: screenNavigationSegue.EXHHomeViewNavigation.rawValue, sender: self)
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var topviewController:EXHSliderSuperViewController?
        if identifier == screenNavigationSegue.EXHHomeViewNavigation.rawValue {
            
            topviewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: loadControllerWithIdentifier.EXHHomeViewContainer.rawValue)  as? EXHHomeViewContainer
            
        } else if identifier == screenNavigationSegue.EXHFavouriteNavigation.rawValue {
            
            topviewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: loadControllerWithIdentifier.EXHFavouriteController.rawValue)  as? EXHFavouriteController
            
        }
       
        
        topviewController!.delegate = self
        centerNavigationController = EXHGlobalNavigationController(rootViewController: topviewController!)
        self.view.addSubview(centerNavigationController!.view)
        addChildViewController(centerNavigationController!)
        centerNavigationController.didMove(toParentViewController: self)
        return false
    }
}
