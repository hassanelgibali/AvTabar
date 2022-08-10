//
//  ITemFlatBarModel.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 09/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
open class ItemFlatBarModel{
    
   open var id:String?
   open var viewController:UIViewController?
   open var displayTitle: String?
   open var titleColor: String?
   open var reporting: String?
   open var iosMinVersion: String?
   open var getRedirectionType: String?
    
    init(id:String,viewController:UIViewController,displayTitle:String,titleColor:String,reporting:String,iosMinVersion:String,getRedirectionType:String) {
        self.id = id
        self.viewController = viewController
        self.displayTitle = displayTitle
        self.titleColor = titleColor
        self.reporting = reporting
        self.iosMinVersion = iosMinVersion
        self.getRedirectionType = getRedirectionType
 
    }
    
    
    
}
