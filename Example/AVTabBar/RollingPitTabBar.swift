//
//  RollingPitTabBar.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 25/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

let pi = CGFloat.pi
let pi2 = CGFloat.pi / 2
var statusHeightDefault = 20
var bottomM = 0

extension CGFloat {
    public func toRadians() -> CGFloat {
        return self * CGFloat.pi / 180.0
    }
}

@IBDesignable class RollingPitTabBar: UITabBar {
    
    @IBInspectable public var barBackColor: UIColor = UIColor.white
    @IBInspectable public var barHeight: CGFloat = 65
    @IBInspectable public var barTopRadius: CGFloat = 10
    @IBInspectable public var barBottomRadius: CGFloat = 40
    @IBInspectable public var circleBackColor: UIColor = UIColor.clear
    @IBInspectable public var circleRadius: CGFloat = 35
    @IBInspectable var marginBottom: CGFloat = 5
    @IBInspectable var marginTop: CGFloat = 0
    
    let marginLeft: CGFloat = 15
    let marginRight: CGFloat = 15
    var backGround: UIColor = UIColor.gray
    let pitCornerRad: CGFloat = 20
    let pitCircleDistanceOffset: CGFloat = 0

    private var barRect: CGRect {
        get {
            let h = 140
            let w = bounds.width//bounds.width - (marginLeft + marginRight)
            let x = bounds.minX// + marginLeft
            let y = CGFloat(bottomM)//marginTop + circleRadius
            
            let rect = CGRect(x: x, y: y, width: w, height: CGFloat(h))
            return rect
        }
    }
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }

    
    func createPitMaskpath(rect: CGRect) -> CGMutablePath {
        let backRect = barRect
        let x: CGFloat = (self.bounds.width / 2) + pitCornerRad
        let y = backRect.origin.y
        
        let center = CGPoint(x: x, y: y)
        
        let maskpath = CGMutablePath()
        maskpath.addRect(rect)
        
        let pit = createPitpath(center: center)
        maskpath.addPath(pit)
        
        return maskpath
    }
    
    func createPitpath(center: CGPoint) -> CGPath {
        let rad = self.circleRadius + 5
        let x = center.x - rad - pitCornerRad
        let y = center.y
        
        let result = UIBezierPath()
        result.lineWidth = 0
        result.move(to: CGPoint(x: x - 0, y: y + 0))
        
        result.addArc(withCenter: CGPoint(x: (x - pitCornerRad), y: (y + pitCornerRad)), radius: pitCornerRad, startAngle: CGFloat(270).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: true)
        
        result.addArc(withCenter: CGPoint(x: (x + rad), y: (y + pitCornerRad ) ), radius: rad, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
        
        result.addArc(withCenter: CGPoint(x: (x + (rad * 2) + pitCornerRad), y: (y + pitCornerRad) ), radius: pitCornerRad, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(270).toRadians(), clockwise: true)
        
        result.addLine(to: CGPoint(x: x + (pitCornerRad * 2) + (rad * 2), y: y)) // rounding errors correction lines
        result.addLine(to: CGPoint(x: 0, y: 0))
        
        result.close()
        
        return result.cgPath
    }
    
    private func createBackgroundpath() -> CGPath {
        let rect = barRect
        let topLeftRadius = self.barTopRadius
        let topRightRadius = self.barTopRadius
        let bottomRigtRadius = self.barBottomRadius
        let bottomLeftRadius = self.barBottomRadius
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topLeftRadius, y:rect.minY))
        
        path.addArc(withCenter: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius), radius: topRightRadius, startAngle:3 * pi2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRigtRadius))
        path.addArc(withCenter: CGPoint(x: rect.maxX - bottomRigtRadius, y: rect.maxY - bottomRigtRadius), radius: bottomRigtRadius, startAngle: 0, endAngle: pi2, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX + bottomRigtRadius, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius), radius: bottomLeftRadius, startAngle: pi2, endAngle: pi, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        path.addArc(withCenter: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius), radius: topLeftRadius, startAngle: pi, endAngle: 3 * pi2, clockwise: true)
        path.close()
        
        return path.cgPath
    }
    
    private lazy var background: CAShapeLayer = {
        let result = CAShapeLayer();
        result.fillColor = self.barBackColor.cgColor
        result.mask = self.backgroundMask
        
        return result
    }()
    
    private lazy var backgroundMask: CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillRule = CAShapeLayerFillRule.evenOdd
        return result
    }()

    private func getTabBarItemViews() -> [(item: UITabBarItem, view: UIView)]{
        guard let items = self.items else {
            return[]
        }
        
        var result: [(item: UITabBarItem, view: UIView)] = []
        for item in items {
            if let v = getViewForItem(item: item) {
                result.append((item: item, view: v))
            }
            
        }
        
        return result
    }
    
    private func getViewForItem(item: UITabBarItem?) -> UIView?{
        if let item = item {
            let v = item.value(forKey: "view") as? UIView
            return v
        }
        
        return nil
        
    }
    
    private func positionItem(barRect: CGRect, totalCount: Int, idx: Int, item: UITabBarItem, view: UIView) {
        let margin: CGFloat = 5
        let x = view.frame.origin.x
        let y = barRect.origin.y + margin
        let h = barHeight - (margin * 2)
        let w = view.frame.width
        view.frame = CGRect(x: x, y: y, width: w, height: h)
    }
 
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        if hasTopNotch {
            sizeThatFits.height = 85
        } else {
            sizeThatFits.height = 65
        }
        return sizeThatFits
    }
    
    private func layoutElements(selectedChanged: Bool) {
        self.background.path = self.createBackgroundpath()
            self.backgroundMask.path = self.createPitMaskpath(rect: self.bounds)
        
        let items = getTabBarItemViews()
        if items.count <= 0 {
            return
        }
        
        let barR = barRect
        let total = items.count
        for (idx, item) in items.enumerated() {
            self.positionItem(barRect: barR, totalCount: total, idx: idx, item: item.item, view: item.view)
        }
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        NotificationCenter.default.addObserver(self, selector:  #selector(statusBarHeightChanged), name: UIApplication.willChangeStatusBarFrameNotification, object: nil)

        background.fillColor = self.barBackColor.cgColor
        self.layoutElements(selectedChanged: false)
    }
 
    private func setup() {
        self.isTranslucent = true
        self.backgroundColor = UIColor.clear //self.parentContainerViewController?.parent?.parent?.view.backgroundColor //
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        
        self.layer.insertSublayer(background, at: 0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }
    
    @objc func statusBarHeightChanged() {
        
        statusHeightDefault = Int(UIApplication.shared.statusBarFrame.size.height)
        if statusHeightDefault == 20 {
            bottomM = 0
        } else {
            bottomM = 20
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
