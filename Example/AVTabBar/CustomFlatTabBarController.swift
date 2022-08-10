//
//  CustomFlatTabBarController.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 02/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SnapKit

public protocol FlatTabbarViewProtocol: AnyObject {
    func didTapItem(tab: ItemFlatBarModel)
}


open class CustomFlatTabBarController: UITabBarController {
    
    //MARK: PROPERTIES
    let CUSTOM_TAB_BAR_HEIGHT: CGFloat = 90.0
    var customTabBar: CustomTabBarView!
    weak var customTabBarDelegate: FlatTabbarViewProtocol?
  open  var tabItems: [ItemFlatBarModel] = []
  open var mainVc = UIViewController()

    //MARK:- LOAD TAB
    open  func loadTabBar() {
        self.viewControllers = [mainVc]
    }
    
    
    //MARK:- SETUP TAB VIEW
    open  func setupCustomTabBar() {
        let frame = tabBar.frame
        tabBar.isHidden = true
        self.customTabBar = CustomTabBarView(menuItems: tabItems, frame: frame)
        self.customTabBar.itemTapped = { [weak self] index in
            guard let self = self else { return }
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
