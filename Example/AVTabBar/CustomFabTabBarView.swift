//
//  CustomFabTabBarView.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 02/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Foundation
import SnapKit
import VUIComponents
import UIKit



//MARK: - CUSTOM TAB BAR VIEW
class CustomFabTabBarView: UIView {
    
    //MARK: PROPERTIES
    @IBOutlet var view: UIView!
    @IBOutlet weak var containerView: RollingPitTabBar!
    let stackViewItems = UIStackView()
    private let CUSTOM_TAB_BAR_CORNER_RADIUS: CGFloat = 15.0
    private let CUSTOM_TAB_BAR_ICON_SIZE = 34
    private let CUSTOM_TAB_BAR_TITLE_HEIGHT = 16
    var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }

    
    var shadowLayer: UIView!
    var itemTapped: ((_ tab: ItemBarModel) -> Void)?
    var viewModel:CustomFabTabBarViewModel!
    
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
        guard let viewFromXib = Bundle.main.loadNibNamed("CustomFabTabBarView", owner: self, options: nil)?[0] as? UIView else { return }
        viewFromXib.frame = self.bounds
        initUi()
        addSubview(viewFromXib)
    }
    
    fileprivate func initUi() {
        if let tabBarView = containerView {
            tabBarView.layer.masksToBounds = true
            tabBarView.circleBackColor = UIColor.clear
            tabBarView.circleRadius = 40
            stackViewItems.spacing = 0
            stackViewItems.alignment = .fill
            stackViewItems.distribution = .fillEqually
            stackViewItems.axis = .horizontal
            stackViewItems.translatesAutoresizingMaskIntoConstraints = false
            stackViewItems.isAccessibilityElement = true
            tabBarView.addSubview(stackViewItems)
            stackViewItems.snp.makeConstraints { (maker) in
                maker.edges.equalToSuperview()
            }
        }
    }
    
    //MARK: - SETUP TAB BAR
    convenience init(viewModel:CustomFabTabBarViewModel, frame: CGRect) {
        self.init(frame: frame)
        setupView()
        self.viewModel = viewModel
        
        var arrangedSubviews = [UIView]()
        
        if viewModel.getItemsCount() > 0 {
            let centerItem = viewModel.getCenterItem()
            for index in 0..<viewModel.getItemsCount() {
                if index == centerItem {
                    let circleItem = self.createCircleTabItem(item: self.viewModel.getSelectedItem(at: index), index: index)
                    circleItem.clipsToBounds = true
                    circleItem.tag = index
                    circleItem.isAccessibilityElement = true
                    let itemView = self.createTabItem(item: self.viewModel.getSelectedItem(at: index), index: index , ishidden: true)
                    itemView.isUserInteractionEnabled = false
                    itemView.backgroundColor = .clear
                    arrangedSubviews.append(itemView)
                   
                }
                else{
                    let itemView = self.createTabItem(item: self.viewModel.getSelectedItem(at: index), index: index, ishidden: false)
                    itemView.clipsToBounds = true
                    itemView.tag = index
                    arrangedSubviews.append(itemView)
                }
            }
            
            
        }

        
        self.setupStackView(views: arrangedSubviews)
        self.containerView.addSubview(stackViewItems)
        
        stackViewItems.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        self.containerView.setNeedsLayout()
        self.containerView.layoutIfNeeded()
        
        //Select index = 0
        self.activateTab(tab: 0)
    }
    
    func setupStackView(views: [UIView]) {
        for subview in stackViewItems.arrangedSubviews {
            subview.removeFromSuperview()
        }
        for view in views {
            stackViewItems.addArrangedSubview(view)
        }
    }
    
    private func setupView() {
        self.containerView.roundCorners(corners: [.topLeft, .topRight], radius: CUSTOM_TAB_BAR_CORNER_RADIUS)
    }
    
    //MARK: - CREATE TAB ITEM VIEW
    func createTabItem(item: ItemBarModel, index: Int,ishidden:Bool) -> UIView {
        //Create View to contain icon and text
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        let itemTitleLabel = AnaVodafoneLabel(frame: CGRect.zero)
        
        itemIconView.image = item.barItemImage
        
        
        itemTitleLabel.text =  !ishidden ? item.categoryName : ""
      //  itemTitleLabel.font = UIFont(name: "regularFont", size: 14.0)
        itemTitleLabel.font = itemTitleLabel.font.withSize(14.0)
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
    
    func createCircleTabItem(item: ItemBarModel, index: Int) -> UIView {

        let centerButton = UIButton(frame: CGRect(x: 40, y:self.frame.size.height-20, width: 60, height: 60))
        centerButton.backgroundColor = UIColor.white
        centerButton.setShadow()
        centerButton.imageView?.snp.makeConstraints({ (make) in
            make.height.width.equalTo(49)
        })
        if #available(iOS 13.0, *) {
            centerButton.setImage(UIImage(systemName: "leaf.fill"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        centerButton.layer.cornerRadius = centerButton.frame.size.height/2
        view.addSubview(centerButton)
        
        centerButton.snp.makeConstraints { (make) in
            make.size.equalTo(65)
            make.centerX.equalToSuperview()
            if hasTopNotch {
                make.bottom.equalToSuperview().inset(30)
            } else {
                make.bottom.equalToSuperview().inset(10)
            }
        }
        centerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        self.layoutIfNeeded()
        return centerButton
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.activateTab(tab: sender.view?.tag ?? 0)
    }
    
    //MARK: - SELECT TAB
    func activateTab(tab: Int) {
        self.itemTapped?(viewModel.getSelectedItem(at: tab))
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
          //  shadowLayer.layer.shadowOpacity = 0.2
            shadowLayer.layer.shadowRadius = 3
            shadowLayer.layer.masksToBounds = true
            shadowLayer.clipsToBounds = false
            
            self.superview?.addSubview(shadowLayer)
            self.superview?.bringSubviewToFront(self)
        }
    }
}
