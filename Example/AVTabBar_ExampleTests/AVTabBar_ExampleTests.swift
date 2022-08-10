//
//  AVTabBar_ExampleTests.swift
//  AVTabBar_ExampleTests
//
//  Created by Vodafone on 10/08/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import AVTabBar_Example

class AVTabBar_ExampleTests: XCTestCase {
    
    var viewModel:CustomFabTabBarViewModel!
    var tabItems: [ItemBarModel] = []


    override func setUp() {
        tabItems.append(ItemBarModel(categoryName: "home", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
        tabItems.append(ItemBarModel(categoryName: "chat with us", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
        tabItems.append(ItemBarModel(categoryName: "profile", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
        tabItems.append(ItemBarModel(categoryName: "Setting", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
        tabItems.append(ItemBarModel(categoryName: "more", actionType: "", actionValue: "", categorized: true, popular: false, isNew: false, isHidden: false, barItem: true, barItemImage: UIImage(systemName: "leaf.fill")!))
        
         viewModel = CustomFabTabBarViewModel(items: tabItems)

    }

    override func tearDown() {
        viewModel = nil
    }
    func testGetItemsCount(){
        XCTAssertEqual(tabItems.count, 5)
    }
    
    func testGetCenterItem(){
        let centerIndex = tabItems.count / 2
        XCTAssertEqual(centerIndex, 2)
        XCTAssertEqual(tabItems[centerIndex].categoryName, "profile")
    }
    

}
