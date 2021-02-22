//
//  PostViewController.swift
//  FullPageTabController_BaseProject_Template
//
//  Created by Matthew Lyles on 2/21/21.
//

import UIKit

class PostViewController: UIViewController {
    
    var model: PostModel
    
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = [UIColor.red, UIColor.gray, UIColor.green, UIColor.blue, UIColor.purple, UIColor.brown, UIColor.cyan].randomElement()

    }
    
}
