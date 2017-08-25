//
//  ContainerViewController.swift
//  myAIDA
//
//  Created by Lew Freyholtz on 19.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import QuartzCore
import RealmSwift

enum MenuStates {
    case menuOpen
    case menuClosed
}


class ContainerViewController: UIViewController {

    
    //MARK: - properties
    
    var centerNavigationController: UINavigationController!
    var centerViewController:ItineraryViewController!
    var menuViewController: MenuViewController?
    
    var currentState: MenuStates = .menuClosed {
        didSet {
            let shouldShowShadow = currentState != .menuClosed
            showShadowForCenterViewController(shouldShowShadow: shouldShowShadow)

        }
    }
    

    //MARK: - constatants
    let centerPanelExpandedOffset: CGFloat = 80
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        centerViewController = UIStoryboard.itineraryViewController()
        centerViewController.delegate = self
        
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
        
        
        
        //MARK - realm init
        //TODO: move realm file to bundle so that all simulators can read it
        
        print("Realm file path: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        let realm = try! Realm()
    }


}



//MARK: itinerary view controller delegate

extension ContainerViewController: ItineraryViewControllerDelegate {
    
    
    //required
    func toggleMenu() {
        //toggle menu code
        

        //TODO:check this!!
        if currentState == .menuClosed {
            
            addMenuPanelViewController()
            animateLeftPanel(shouldExpand: true)
            // open menu animation
        } else {
            animateLeftPanel(shouldExpand: false)
        }
    }
    
    func addMenuPanelViewController() {
        //dynamically add in menu view controller
        
        if (menuViewController == nil) {
            menuViewController = UIStoryboard.menuViewController()
            
            //TODO: load data for menu here
            
            addChildSidePanelController(sidePanelController:menuViewController!)
            menuViewController?.delegate = self
            
//            print("Menu view controller added")
        }
    }
    
    
    
    func animateLeftPanel(shouldExpand: Bool){
        
        
        var scale:CGFloat
        var targetX = CGFloat(0)
        var nextState : MenuStates
        
        if (shouldExpand) {
            scale = 0.5
            targetX = (UIScreen.main.bounds.size.width - self.centerNavigationController.view.frame.size.width / 2) + centerPanelExpandedOffset
            nextState = .menuOpen
        } else {
            scale = 1.0
            targetX = 0
            nextState = .menuClosed
        }
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.centerNavigationController.view.transform = CGAffineTransform(scaleX:scale, y:scale)
                        self.centerNavigationController.view.frame.origin.x = targetX
                       },
                       completion: nil)
        currentState = nextState

    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    // add child controller to viewControllerStack
    func addChildSidePanelController(sidePanelController:MenuViewController) {
        
        view.insertSubview(sidePanelController.view, at:0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
//        print("Inserted controller into heirarchy")
    }
    


}

extension ContainerViewController: MenuViewControllerDelegate {
    func navSelected(_ topic: Topic) {
        
        
        
        // invoke new view controller from storyboard;
        
        let topicList = UIStoryboard.topicViewController()
        let topicNavController = UINavigationController(rootViewController: topicList!)
        
//        let topGradient = CAGradientLayer()
        
        
        //        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white

        
        topicNavController.navigationBar.transparentNavigationBar()
        
        topicList?.navController = topicNavController
        
        
        topicList?.topicData = topic
        
        // close menu
        
        toggleMenu()
        // push view controller on to stack
        
        centerNavigationController.present(topicNavController, animated: true)
        
    }
}

extension ContainerViewController : TopicViewControllerDelegate {

    func categorySelected(_ category:Category) {
        
        print("Category selected delegate")
        let catalogList = UIStoryboard.catalogListViewController()
        
        catalogList?.navController = centerNavigationController
        
        
        print("Category list passed: \(category.title)")
        //        catalogList?.listData = category
    }
    


}

//MARK: utility
fileprivate extension UIStoryboard {
    
     
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    class func menuViewController() -> MenuViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "menu") as? MenuViewController
    }
    
    
    class func itineraryViewController() -> ItineraryViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "itinerary") as? ItineraryViewController
    }
    

    class func topicViewController() -> TopicViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier:"topic") as?
        TopicViewController
    }
    
    
    class func catalogListViewController() -> CatalogListCollectionViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier:"imageList") as? CatalogListCollectionViewController
    }
    
    class func venueDetailController() -> VenueDetailController? {
        return mainStoryboard().instantiateViewController(withIdentifier:"venueDetail") as? VenueDetailController
    }
    
}

fileprivate extension UINavigationBar {
    func transparentNavigationBar() {
        self.isTranslucent = true
        self.barTintColor = UIColor.clear
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.tintColor = UIColor.white
        
        
    }
}

