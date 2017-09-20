//
//  CategoryListViewController.swift
//  myAIDADynamicPrototype
//
//  Created by Lew Freyholtz on 26.06.17.
//  Copyright © 2017 Lew Freyholtz. All rights reserved.
//

import UIKit
import RealmSwift

protocol TopicViewControllerDelegate {
    
    func categorySelected(_ category:Category)
}

class TopicViewController: UIViewController {

    // @IBOutlet weak var CloseButton: UIButton!

    
    // for hiding statusbar
    var statusBarHidden:Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    
    struct storyboardValues {
        static let cellIdentifier = "categoryCell"
        static let showList = "showList"
    }
    var delegate: TopicViewControllerDelegate?
    var topicData:Topic?
    var members:AnyObject?
    var selectedCategory:Category?
    
    @IBOutlet weak var collectionView: UICollectionView!

    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let width = collectionView!.bounds.width
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        layout?.itemSize = CGSize(width: width, height: 62)

        
        // close custom icon
        let icon = UIImage(named: "icn_close_white")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: icon,
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(dismiss(_:))
        )
        
        self.navigationItem.title = ""

    }
    
    
    func dismiss(_ sender:UIBarButtonItem) {
        dismiss(animated:true, completion:nil)
    }
    

    

}


//MARK: CollectionView Data
extension TopicViewController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let topicData = topicData {
            
            return topicData.categories.count
        
        } else {
            
            return 1
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: storyboardValues.cellIdentifier, for: indexPath) as! CategoryCell
        
        
        cell.backgroundColor = UIColor.white
        
        let bottomBorder = UIView(frame: CGRect(x:0, y:cell.frame.size.height - 1, width:cell.frame.size.width, height:1))
        bottomBorder.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
        cell.addSubview(bottomBorder)
        cell.category = topicData?.categories[indexPath.item]
        
        
        

        return cell
    }
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "topicHeader",
                                                                             for: indexPath) as! TopicHeader
            
            if let topicData = topicData {
                headerView.topic = topicData
            }
            
            return headerView
            
        default:
            assert(false, "unexpected element kind")
            
        }
    }
    
    
    /// scroll behaviors (e.g. show / hide nav bar)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hideNavBar()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showNavBar()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        showNavBar()
    }
}

extension TopicViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = topicData?.categories[indexPath.item]
        self.performSegue(withIdentifier:storyboardValues.showList, sender: category)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == storyboardValues.showList {
            let listController = segue.destination as! CatalogListCollectionViewController
            let selectedCategory = sender as! Category
            listController.listData = selectedCategory
            listController.transitioningDelegate = nil
            


        }
        
    }
    
}

extension TopicViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:UIScreen.main.bounds.width, height:94 )
    }
    
}

// showing hiding status bar
extension TopicViewController  {
    
    func hideNavBar() {
        
        guard let navController = self.navigationController else { return }
        let navBarFrame:CGRect = navController.navigationBar.frame
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            
            navController.navigationBar.alpha = 0.0
            
        }, completion: {
            
            ( completed ) in
            
            navController.navigationBar.frame = CGRect.zero
//            navController.navigationBar.frame = CGRect(x: 0, y: 20, width: navBarFrame.size.width, height: 44)
            navController.navigationBar.frame = navBarFrame
            self.statusBarHidden = true


        })
        
       
           }
    
    func showNavBar() {
        
        guard let navController = self.navigationController else { return }
        let navBarFrame:CGRect = navController.navigationBar.frame
        
        
        UIView.animate(withDuration: 0.33, delay: 1.0, options: .curveEaseInOut, animations: {
            
            navController.navigationBar.alpha = 1.0
            
        }, completion: {
            
            ( completed ) in
            
                navController.navigationBar.frame = CGRect.zero
                navController.navigationBar.frame = navBarFrame
//                navController.navigationBar.frame = CGRect(x: 0, y: 20, width: navBarFrame.size.width, height: 44)
                self.statusBarHidden = false

        })
        
        
       
        
    }

    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
 

}
