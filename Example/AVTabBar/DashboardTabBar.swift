//
//  DashboardTabBar.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 25/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

protocol DashboardTabbarViewProtocol: AnyObject {
    func didTapOffersBtn()
    func didTapProfileBtn()
    func didTapLogoBtn()
    func didTapInboxBtn()
    func didTapMenuBtn()
    func didTapTobiFace()
    func didTapItem(withkey key:String , categoryNameEn:String)
}

enum DashboardTabbarViewIdentifier: String {
    case tabBarList = "tabBarLis"
}

class DashboardTabBar: UIView {
    
    @IBOutlet private weak var tabBarView: RollingPitTabBar?
    weak var delegate: DashboardTabbarViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        guard let view = Bundle.main.loadNibNamed("DashboardTabBar", owner: self, options: nil)?[0] as? UIView else {
            return
        }
        
        self.addSubview(view)
        
        view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        setUpDefaultTabBar()
       
    }
    
    func setUpDefaultTabBar() {
        
        let home = ItemBarView()
        home.setTitle("Home", "newHomeIcon")
        home.setColorTitle(color: UIColor.red)
        home.actionBlock = { [weak self]   in
            self?.delegate?.didTapLogoBtn()
        }
        home.isAccessibilityElement = true
        home.accessibilityIdentifier = DashboardTabbarViewIdentifier.tabBarList.rawValue + "ـhome"

        let offer = ItemBarView()
        offer.setTitle("Offers", "homeOffers")
        offer.actionBlock = {[weak self] in
            self?.delegate?.didTapOffersBtn()
        }
        offer.isAccessibilityElement = true
        offer.accessibilityIdentifier = DashboardTabbarViewIdentifier.tabBarList.rawValue + "ـhomeOffers"

        let inbox = ItemBarView()
        inbox.setTitle("Inbox", "inbox")
        inbox.actionBlock = {[weak self] in
            self?.delegate?.didTapInboxBtn()
        }
        inbox.isAccessibilityElement = true
        inbox.accessibilityIdentifier = DashboardTabbarViewIdentifier.tabBarList.rawValue + "ـinbox"
        
        let more = ItemBarView()
        more.setTitle("More", "more")
        more.actionBlock = {[weak self] in
            self?.delegate?.didTapMenuBtn()
        }
        more.isAccessibilityElement = true
        more.accessibilityIdentifier = DashboardTabbarViewIdentifier.tabBarList.rawValue + "ـmore"

        let profile = CircleItemBarView()
        profile.isProfile = true
        profile.buildview()
        profile.actionBlock = {[weak self] in
            self?.delegate?.didTapProfileBtn()
        }
        profile.isAccessibilityElement = true
        profile.accessibilityIdentifier = DashboardTabbarViewIdentifier.tabBarList.rawValue + "ـprofile"

    }
    

}
