//
//  ViewController.swift
//  AVTabBar
//
//  Created by V21HElGebally on 07/20/2022.
//  Copyright (c) 2022 V21HElGebally. All rights reserved.
//

import UIKit
import AVTabBar

//class ViewController: CustomFlatTabBarController {

class ViewController: CustomFabTabBarController {

    var homeVc : UIViewController?
    var secondVc : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeVc  = (storyboard?.instantiateViewController(withIdentifier: "Home"))!
        secondVc = (storyboard?.instantiateViewController(withIdentifier: "Second"))!
        mainVc = homeVc!
        self.viewControllers = [homeVc!,secondVc!]
        if #available(iOS 13.0, *) {
            
//            tabItems.append(ItemFlatBarModel(id: "", viewController: homeVc!, displayTitle: "Home", titleColor: "red", reporting: "", iosMinVersion: "", getRedirectionType: ""))
//            tabItems.append(ItemFlatBarModel(id: "", viewController: homeVc!, displayTitle: "profile", titleColor: "red", reporting: "", iosMinVersion: "", getRedirectionType: ""))
//            tabItems.append(ItemFlatBarModel(id: "", viewController: homeVc!, displayTitle: "Setting", titleColor: "red", reporting: "", iosMinVersion: "", getRedirectionType: ""))
            tabItems.append(ItemBarModel(categoryName: "home", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "chat with us", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "profile", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "Setting", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "more", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            // Fallback on earlier versions
        }
        self.setupCustomTabBar()
        self.tabBarController?.selectedIndex = 0
        // Do any additional setup after loading the view, typically from a nib.
        self.customTabBarDelegate = self
    }


}
//extension ViewController : FlatTabbarViewProtocol {

extension ViewController : FabTabbarViewProtocol {
    func didTapItem(tab: ItemBarModel) {
        if tab.categoryName == "Setting"  {
            mainVc = secondVc!
        }
        else {
            mainVc = homeVc!

        }
        print(tab.categoryName ?? "")
        self.loadTabBar()
    }
}
