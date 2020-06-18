//
//  StartingViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/18/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {

    var opponent: Player!
    
    init(opponent: Player){
        super.init(nibName: nil, bundle: nil)
        self.opponent = opponent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
            tabBarController?.tabBar.isHidden = true
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .bgcolor
            navigationController?.navigationBar.barTintColor = .customyellow
            navigationController?.navigationBar.titleTextAttributes = [
                // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.tintColor = .white
            
            print(opponent.name)
            
        }
        
        
        
      
        
    


}
