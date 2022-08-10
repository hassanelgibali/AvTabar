//
//  CustomFabTabBarViewController.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 02/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SnapKit

public protocol FabTabbarViewProtocol: AnyObject {
    func didTapItem(tab: ItemBarModel)
}


open class CustomFabTabBarController: UITabBarController {
    
    //MARK: PROPERTIES
    let CUSTOM_TAB_BAR_HEIGHT: CGFloat = 90.0
    var customTabBar: CustomFabTabBarView!
    weak var customTabBarDelegate: FabTabbarViewProtocol?

    open   var tabItems: [ItemBarModel] = []
    open var mainVc = UIViewController()

    
    
    //MARK:- LOAD TAB
    open func loadTabBar() {
        self.viewControllers = [mainVc]
    }
     
    open func hideTabBar(){
         customTabBar.view.isHidden = true
     }
    open func showTabBar(){
         customTabBar.view.isHidden = false
     }
    
    //MARK:- SETUP TAB VIEW
     open func setupCustomTabBar() {
        let frame = tabBar.frame
        tabBar.isHidden = true
         let viewModel = CustomFabTabBarViewModel(items: tabItems)
         self.customTabBar = CustomFabTabBarView(viewModel: viewModel, frame: frame)
        self.customTabBar.itemTapped = { [weak self] item in
            guard let self = self else { return }
            self.customTabBarDelegate?.didTapItem(tab: item)
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
