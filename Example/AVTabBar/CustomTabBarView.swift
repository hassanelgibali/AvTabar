//
//  CustomTabBarView.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 02/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SnapKit
import VUIComponents

enum CustomTabBarViewIdentifier: String {
    case containerView = "Login_"
}

//MARK: - CUSTOM TAB BAR VIEW
class CustomTabBarView: UIView {
    
    //MARK: PROPERTIES
    @IBOutlet weak var containerView: UIView!
    private let CUSTOM_TAB_BAR_CORNER_RADIUS: CGFloat = 15.0
    private let CUSTOM_TAB_BAR_ICON_SIZE = 34
    private let CUSTOM_TAB_BAR_TITLE_HEIGHT = 16
    
    var shadowLayer: UIView!
    var itemTapped: ((_ tab: Int) -> Void)?
    
    //MARK:- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed("CustomTabBarView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    //MARK: - SETUP TAB BAR
    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        setupView()
        
        //Create Horizontal Stack
        let stackViewItems = UIStackView()
        stackViewItems.axis = .horizontal
        stackViewItems.distribution  = .fillEqually
        stackViewItems.alignment = .fill
        
        //Adding items to stack
        for i in 0 ..< menuItems.count {
            let itemView = self.createTabItem(item: menuItems[i], index: i)
            itemView.accessibilityIdentifier = "\(CustomTabBarViewIdentifier.containerView.rawValue)\(menuItems[i].id ?? "")"
            itemView.clipsToBounds = true
            itemView.tag = i
            stackViewItems.addArrangedSubview(itemView)
        }
        
        self.containerView.addSubview(stackViewItems)
        
        stackViewItems.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        self.containerView.setNeedsLayout()
        self.containerView.layoutIfNeeded()
        
        //Select index = 0
        self.activateTab(tab: 0)
    }
    
    private func setupView() {
        self.containerView.roundCorners(corners: [.topLeft, .topRight], radius: CUSTOM_TAB_BAR_CORNER_RADIUS)
    }
    
    //MARK: - CREATE TAB ITEM VIEW
    func createTabItem(item: TabItem, index: Int) -> UIView {
        //Create View to contain icon and text
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        let itemTitleLabel = AnaVodafoneLabel(frame: CGRect.zero)
        
        
        
        
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = UIFont(name: "regularFont", size: 14.0)!
        itemTitleLabel.textColor = UIColor(hexString: item.titleColor)
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.clipsToBounds = true
        
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.clipsToBounds = true
        
        itemIconView.snp.makeConstraints { make in
            make.height.equalTo(CUSTOM_TAB_BAR_ICON_SIZE)
            make.width.equalTo(CUSTOM_TAB_BAR_ICON_SIZE)
            make.top.equalTo(15)
            make.centerX.equalTo(tabBarItem.snp.centerX)
        }
        
        itemTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(CUSTOM_TAB_BAR_TITLE_HEIGHT)
            make.top.equalTo(itemIconView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalTo(itemIconView.snp.centerX)
        }
        
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.activateTab(tab: sender.view?.tag ?? 0)
    }
    
    //MARK: - SELECT TAB
    func activateTab(tab: Int) {
        self.itemTapped?(tab)
    }
    
    //MARK: - DRAW SHADOW
    override func draw(_ rect: CGRect) {
        if shadowLayer == nil {
            shadowLayer = UIView(frame: self.frame)
            shadowLayer.backgroundColor = UIColor.clear
            shadowLayer.layer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                                        byRoundingCorners: [.topLeft, .topRight],
                                                        cornerRadii: CGSize(width: CUSTOM_TAB_BAR_CORNER_RADIUS,
                                                                            height: CUSTOM_TAB_BAR_CORNER_RADIUS)).cgPath
            shadowLayer.layer.shadowOffset = CGSize(width: 0, height: -2)
            shadowLayer.layer.shadowOpacity = 0.3
            shadowLayer.layer.shadowRadius = 3
            shadowLayer.layer.masksToBounds = true
            shadowLayer.clipsToBounds = false
            
            self.superview?.addSubview(shadowLayer)
            self.superview?.bringSubviewToFront(self)
        }
    }
}
