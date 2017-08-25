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
    
    struct storyboardValues {
        static let cellIdentifier = "categoryCell"
        static let showList = "showList"
    }
    var delegate: TopicViewControllerDelegate?
    var parentController : UINavigationController?
    var navController : UINavigationController?
    var topicData:Topic?
    var members:AnyObject?
    var selectedCategory:Category?
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let width = collectionView!.bounds.width
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        layout?.itemSize = CGSize(width: width, height: 62)

        let icon = UIImage(named: "icn_close_white")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: icon,
            style: UIBarButtonItemStyle.plain,
            target: self,
            action: #selector(dismiss(_:))
        )
        
        self.navigationItem.title = ""
        var colors = [UIColor]()
        colors.append(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5))
        colors.append(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        navigationController?.navigationBar.shadowImage = nil
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
            
//            print("Sending list data:\(selectedCategory)")

        }
        
    }
    
}

extension TopicViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:UIScreen.main.bounds.width, height:94 )
    }
    
}


// MARK NavBar Customization
extension UINavigationBar {
    
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += 20
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
        isTranslucent = true
        barTintColor = UIColor.clear

        
    }
}

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}

