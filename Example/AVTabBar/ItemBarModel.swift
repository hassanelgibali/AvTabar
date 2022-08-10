//
//  ItemBarViewModel.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 01/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

open class ItemBarModel{
    
    open  var categoryName:String?
    open  var actionType:String?
    open  var actionValue:String?
    open  var categorized:Bool?
    open  var popular:Bool?
    open  var isNew:Bool?
    open  var isHidden:Bool?
    open  var barItem:Bool?
    open  var barItemImage:UIImage?
    
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
