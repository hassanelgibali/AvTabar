//
//  ItemBarViewModel.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 01/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ItemBarModel{
    
    var categoryName:String?
    var actionType:String?
    var actionValue:String?
    var categorized:Bool?
    var popular:Bool?
    var isNew:Bool?
    var isHidden:Bool?
    var barItem:Bool?
    var barItemImage:UIImage?
    
    init(categoryName:String,actionType:String,actionValue:String,categorized:Bool,popular:Bool,isNew:Bool,isHidden:Bool,barItem:Bool,barItemImage:UIImage) {
        self.categoryName = categoryName
        self.actionType = actionType
        self.actionValue = actionValue
        self.categorized = categorized
        self.popular = popular
        self.isHidden = isHidden
        self.barItem = barItem
        self.barItemImage = barItemImage
 
    }
    
    
    
}
