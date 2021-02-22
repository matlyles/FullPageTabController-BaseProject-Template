//
//  ReuseViewController.swift
//  FullPageTabController_BaseProject_Template
//
//  Created by Matthew Lyles on 2/21/21.
//

import UIKit

class ReuseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.unselectedItemTintColor = .label
        self.tabBarController?.tabBar.tintColor = .label
        self.tabBarController?.tabBar.barTintColor = .systemBackground
        self.tabBarController?.tabBar.isOpaque = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
}
        
