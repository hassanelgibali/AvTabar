//
//  ViewController.swift
//  AVTabBar
//
//  Created by V21HElGebally on 07/20/2022.
//  Copyright (c) 2022 V21HElGebally. All rights reserved.
//

import UIKit
import AVTabBar

class ViewController: CustomFabTabBarController {

  //  let tabarView = DashboardTabBar()
    var homeVc : UIViewController?
    var secondVc : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            tabItems.append(ItemBarModel(categoryName: "home", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "chat with us", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "profile", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "Setting", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
            tabItems.append(ItemBarModel(categoryName: "more", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
        } else {
            // Fallback on earlier versions
        }
        homeVc  = (storyboard?.instantiateViewController(withIdentifier: "Home"))!
        secondVc = (storyboard?.instantiateViewController(withIdentifier: "Second"))!
        mainVc = homeVc!
        self.viewControllers = [homeVc!,secondVc!]
        self.loadTabBar()
        self.tabBarController?.selectedIndex = 0
    //    addTabbarView()
        // Do any additional setup after loading the view, typically from a nib.
        self.customTabBarDelegate = self
    }


    
    
//    func addTabbarView() {
//        self.dashboardTabar.addSubview(tabarView)
//        self.dashboardTabar.layoutIfNeeded()
//        tabarView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//    }
}

extension ViewController : FabTabbarViewProtocol {
    func didTapItem(tab: Int) {
        if tab == 1 {
            mainVc = secondVc!
        }
        else {
            mainVc = homeVc!

        }
        print(tab)
        self.loadTabBar()
    }
}
