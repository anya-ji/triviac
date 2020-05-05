//
//  TabBarController.swift
//  Triviac
//
//  Created by Anya Ji on 5/4/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let createVC = CreateViewController()
        createVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let savedVC = SavedViewController()

        savedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        let VCList = [createVC,savedVC]

        viewControllers = VCList.map { UINavigationController(rootViewController: $0) }
        
    }
    

   
}
