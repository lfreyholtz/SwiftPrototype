//
//  ItineraryViewController.swift
//  myAIDA
//
//  Created by Lew Freyholtz on 19.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit




class ItineraryViewController: UIViewController {


    
    let interactor = Interactor()
    var selectedTopic: Topic?

    @IBAction func menuTapped(_ sender:AnyObject) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    @IBAction func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
       let translation = sender.translation(in: view)
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        
        MenuHelper.mapGestureStateToInteractor(sender.state, progress: progress, interactor: interactor, triggerSegue: {self.performSegue(withIdentifier: "openMenu", sender: nil)})
        
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMenu" {
            if let destinationViewController = segue.destination as? MenuViewController {
                destinationViewController.transitioningDelegate = self
                destinationViewController.delegate = self
                destinationViewController.interactor = interactor
            }
            
        } else if segue.identifier == "openTopic" {
//            print("openTopic Prepare")
            if let destinationViewController = segue.destination as? UINavigationController {
                destinationViewController.navigationBar.tintColor = UIColor.white
                if let targetController = destinationViewController.topViewController as? TopicViewController {
                    
                    targetController.topicData = selectedTopic
                }
            }
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}




extension ItineraryViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
        
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}



extension ItineraryViewController : MenuViewControllerDelegate {
    
    func openCatalog(_ topic: Topic) {
        
//        print("opening catalog topic screen")
            selectedTopic = topic
            performSegue(withIdentifier: "openTopic", sender: nil)

    }
}
