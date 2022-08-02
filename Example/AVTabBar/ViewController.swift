//
//  ViewController.swift
//  AVTabBar
//
//  Created by V21HElGebally on 07/20/2022.
//  Copyright (c) 2022 V21HElGebally. All rights reserved.
//

import UIKit
import AVTabBar

class ViewController: UIViewController {

    @IBOutlet weak var dashboardTabar: DashboardTabBar!
  //  let tabarView = DashboardTabBar()
    override func viewDidLoad() {
        super.viewDidLoad()
     //   addTabbarView()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func addTabbarView() {
//        self.dashboardTabar.addSubview(tabarView)
//        self.dashboardTabar.layoutIfNeeded()
//        tabarView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//    }
}

