//
//  CustomFabTabBarViewModel.swift
//  AVTabBar_Example
//
//  Created by Vodafone on 10/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

class CustomFabTabBarViewModel {

   var items: [ItemBarModel]
    
    init(items: [ItemBarModel]) {
        self.items = items
    }
    
    func getItemsCount() -> Int {
        return items.count
    }
    func getCenterItem() -> Int {
        let centerIndex = items.count / 2
        return centerIndex
    }
    
    
    func getSelectedItem(at index: Int) -> ItemBarModel {
        return items[index]
    }
 
  
    
}
