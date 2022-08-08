//
//  CircleItemBarView.swift
//  Ana Vodafone
//
//  Created by abdelmoniem on 2/12/21.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import UIKit
import VUIComponents

class CircleItemBarView: UIView {
        
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    var isProfile:Bool = false
  //  var actionBlock : ActionBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        
        guard let view = Bundle.main.loadNibNamed("CircleItemBarView", owner: self, options: nil)?[0] as? UIView else {
            return
        }
        
        self.addSubview(view)
        
        view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }

    
    func setModel(model:ItemBarModel) {
        self.avatarImage.image = model.barItemImage
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = model.actionValue

    }

    func buildview() {
        self.buildProfileView()
    }
    

    func buildProfileView() {
        containerView.layer.cornerRadius = containerView.frame.size.height / 2
    }
    

}
