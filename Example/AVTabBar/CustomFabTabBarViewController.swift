//
//  CustomFabTabBarViewController.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 02/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SnapKit

protocol FabTabbarViewProtocol: AnyObject {
    func didTapItem(tab: Int)
}


 class CustomFabTabBarController: UITabBarController {
    
    //MARK: PROPERTIES
    let CUSTOM_TAB_BAR_HEIGHT: CGFloat = 90.0
    var customTabBar: CustomFabTabBarView!
    weak var customTabBarDelegate: FabTabbarViewProtocol?

    var tabItems: [ItemBarModel] = []
    var mainVc = UIViewController()

    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- LOAD TAB
     func loadTabBar() {
        setupCustomTabBar()
        self.viewControllers = [mainVc]
        self.selectedIndex = 0
    }
    
    //MARK:- SETUP TAB VIEW
    private func setupCustomTabBar() {
        let frame = tabBar.frame
        tabBar.isHidden = true
        self.customTabBar = CustomFabTabBarView(menuItems: tabItems, frame: frame)
        self.customTabBar.itemTapped = { [weak self] index in
            guard let self = self else { return }
          //  self.changeTab(tab: index)
            self.customTabBarDelegate?.didTapItem(tab: index)
        }
        self.customTabBar.didMoveToSuperview()
        self.view.addSubview(customTabBar)
        
        customTabBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(tabBar)
            make.height.equalTo(CUSTOM_TAB_BAR_HEIGHT)
        }
        self.view.layoutIfNeeded()
    }
    
    
}
