//
//  TabBarBuilderProtocol.swift
//  AVTabBar_Example
//
//  Created by Hassan Ashraf on 28/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol TabBarBuilderProtocol {
    var horizontalPadding: CGFloat { get }
    var viewsWidth : CGFloat { get }
    func buildCardsList(listViews: [UIView], containerView: UIView)
}

extension TabBarBuilderProtocol {
    
    var horizontalPadding: CGFloat {
        return 0
    }
    
    var viewsWidth: CGFloat {
        return 80
    }
    
    func buildCardsList(listViews: [UIView], containerView: UIView) {

        containerView.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
        
        guard listViews.count > 0 else { return }
        
        for i in 0..<listViews.count {
            
            containerView.addSubview(listViews[i])
            
            listViews[i].snp.makeConstraints { make in
                if i == 0 {
                    make.leading.equalTo(containerView.snp.leading)
                } else {
                    make.leading.equalTo(listViews[i - 1].snp.trailing)
                }
                
                make.top.equalTo(containerView.snp.top)
                make.bottom.equalTo(containerView.snp.bottom)
                make.width.equalTo(viewsWidth)
                
                if i == listViews.count - 1 {
                    make.trailing.equalTo(containerView.snp.trailing).offset(-horizontalPadding)
                }
            }
        }
    }
}

