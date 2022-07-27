//

//  flexGiftsBreakdownCell.swift

//  Ana Vodafone
//  Created by abdelmoniem on 6/16/19.

//  Copyright © 2019 Vodafone Egypt. All rights reserved.

//

import UIKit
import  Foundation

@objc public class FlexGiftsBreakdownCell: UITableViewCell {
    
    @IBOutlet weak var giftTitleLabel: UILabel!
    @IBOutlet weak var giftDescribtionLabel: UILabel!
    @IBOutlet weak var giftValidDate: UILabel!
    @IBOutlet weak var giftValidDateTitle: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var dashedView: UIView!
    
    @IBOutlet weak var progressLabel: KAProgressLabel!
    
    
    @objc public func setModel(model: ExpandCellWithCarouselModel)  {
        if (model.giftTitleLabel != nil){
            self.giftTitleLabel.text = model.giftTitleLabel
        }
        
        if (model.giftDescriptionLabel != nil){
            self.giftDescribtionLabel.attributedText = model.giftDescriptionLabel
        }
        
        if (model.giftValidDate != nil){
            self.giftValidDate.text = model.giftValidDate
        }
        
        if (model.giftValidDateTitle != nil){
            self.giftValidDateTitle.text = model.giftValidDateTitle
        }
        
        if (model.giftImageView != nil){
            self.giftImageView.image = model.giftImageView
        }
        
        self.progressLabel.setProgress(model.progessValue, timing: TPPropertyAnimationTimingEaseOut, duration: 1, delay: 0 )
    }
    
    func drawDashedLineTop(view :UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: self.bounds.size.width, y: 0)])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    
    
    override public func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.drawDashedLineTop(view : self.dashedView)
        progressLabel.backBorderWidth = 3.0
        progressLabel.frontBorderWidth = 3.0
        progressLabel.takoBarLowProgressColor = UIColor(red: 0.0, green: 176/255, blue: 255, alpha: 1)
        progressLabel.takoBarDefaultProgressColor = UIColor(red: 0.0, green: 176/255, blue: 255, alpha: 1)
        progressLabel.takoBarMediumProgressColor = UIColor(red: 0.0, green: 176/255, blue: 255, alpha: 1)
        progressLabel.colorTable = ["fillColor": UIColor.clear,"trackColor":UIColor(red: 235/255, green: 234/255, blue: 235/255, alpha: 1),"progressColor" :UIColor(red:0.0, green: 176/255, blue: 202/255, alpha: 1)]
        
    }
    
}
