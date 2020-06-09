//
//  TabBarController.swift
//  Triviac
//
//  Created by Anya Ji on 5/4/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import Firebase



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

        let profileVC = ProfileViewController()
        let profile = UIImage(named: "profile")?.resized(to: CGSize(width: 30, height: 30))
        profileVC.tabBarItem = UITabBarItem(title: "", image: profile, tag: 2)
        
       
        UITabBar.appearance().tintColor = UIColor(red: 1.00, green: 0.69, blue: 0.12, alpha: 1.00)
        let VCList = [createVC,savedVC,profileVC]
        viewControllers = VCList.map { UINavigationController(rootViewController: $0) }
        
    }
    
//   static func addUserListener() {
//      listenHandler = Auth.auth().addStateDidChangeListener { (auth, user) in
//          if user == nil {
//              // We are Logged Out of Firebase.
//              // Move to Login Screen
//          } else {
//              // we are Logged In to Firebase.
//              // Move to Main Screen
//          }
//    }
//    }
    
   
}
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
