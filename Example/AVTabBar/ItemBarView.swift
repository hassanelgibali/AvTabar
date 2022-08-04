//
//  ItemBarView.swift
//  TabBar
//
//  Created by Vodafone on 28/06/2022.
//

import UIKit
import VUIComponents
import SnapKit

class ItemBarView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemLabel: AnaVodafoneLabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var actionBlock:ActionBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        
        guard let view = Bundle.main.loadNibNamed("ItemBarView", owner: self, options: nil)?[0] as? UIView else {
            return
        }
        
        self.addSubview(view)
        
        view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        self.prepareUi()
    }
    
    func prepareUi() {
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapActionBtn(_:)))
        gesture.numberOfTapsRequired = 1
        containerView?.isUserInteractionEnabled = true
        containerView?.addGestureRecognizer(gesture)
    }
    
    func setModel(model:ItemBarModel) {
        self.itemLabel.text = model.categoryName
        if #available(iOS 13.0, *) {
            self.imageView.image = UIImage(systemName: "leaf.fill")
        } else {
            // Fallback on earlier versions
        }
          
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = model.actionValue
    }
    
    func setTitle(_ title:String ,_ witnImage:String) {
        self.itemLabel.txt = title
        self.imageView.image = UIImage(named: witnImage)
    }
    func setColorTitle(color:UIColor) {
        self.itemLabel.textColor = color
    }
   
    @objc fileprivate func didTapActionBtn(_ sender: UIButton) {
        if actionBlock != nil {
            self.actionBlock?()
        }
    }
}
