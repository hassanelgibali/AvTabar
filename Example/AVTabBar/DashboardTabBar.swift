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
       
    }
    

}
