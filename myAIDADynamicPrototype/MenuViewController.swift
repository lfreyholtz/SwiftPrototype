//
//  MenuViewController.swift
//  myAIDA
//
//  Created by Lew Freyholtz on 19.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import RealmSwift

protocol MenuViewControllerDelegate {
    func openCatalog(_ topic: Topic)
}

class MenuViewController: UIViewController {

    var interactor: Interactor? = nil
    
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .left)
        
        MenuHelper.mapGestureStateToInteractor(sender.state, progress: progress, interactor: interactor, triggerSegue: {
            self.dismiss(animated: true, completion: nil)
            
        })
    }
    
    @IBAction func closeMenu(_ sender: Any) {
        dismiss(animated:true, completion:nil)
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: MenuViewControllerDelegate?
    
    var topics: Results<Topic>!
    
    let identifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainRealm = try! Realm(configuration:RealmConfig.main.configuration)

        topics = mainRealm.objects(Topic.self)
        
        collectionView.dataSource = self
        collectionView.delegate = self


        self.view.backgroundColor = UIColor(red: 187/255, green: 229/255, blue: 0/255, alpha: 1.0)
        // Do any additional setup after loading the view.
    }


}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTopic = topics[indexPath.row]
        print("selected topic: \(String(describing: selectedTopic.title))")
        dismiss(animated: true, completion: {
            self.delegate?.openCatalog(selectedTopic)
        })
    }
    

}

//
extension MenuViewController: UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NavCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! NavCell
        

        cell.topic = topics[indexPath.item]
        

        cell.backgroundColor = UIColor(red: 178/255, green: 0/255, blue: 142/255, alpha: 1.0)
        return cell
    }
    
}

