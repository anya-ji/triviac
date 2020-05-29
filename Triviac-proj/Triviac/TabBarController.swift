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
        let home = UIImage(named: "home")?.resized(to: CGSize(width: 30, height: 30))
        createVC.tabBarItem = UITabBarItem(title: "", image: home, tag: 0)

        let savedVC = SavedViewController()
        let saved = UIImage(named: "saved")?.resized(to: CGSize(width: 30, height: 30))
        savedVC.tabBarItem = UITabBarItem(title: "", image: saved, tag: 1)

        UITabBar.appearance().tintColor = UIColor(red: 1.00, green: 0.69, blue: 0.12, alpha: 1.00)
        let VCList = [createVC,savedVC]
        viewControllers = VCList.map { UINavigationController(rootViewController: $0) }
        
    }
    
   
}
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
