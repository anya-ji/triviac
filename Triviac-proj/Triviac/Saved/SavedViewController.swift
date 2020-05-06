//
//  SavedViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/4/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {
    var savedView: UICollectionView!
    var addButton: UIBarButtonItem!
    
    let padding: CGFloat = 10
    
    let savedrid = "savedrid"
    
    let bgcolor = UIColor(red: 0.34, green: 0.34, blue: 0.38, alpha: 1.00)
    let btcolor = UIColor(red: 0.39, green: 0.51, blue: 0.51, alpha: 1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgcolor
        self.title = "Saved"
        
        //add button
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.leftBarButtonItem = addButton
        
    }
    
    //push edit
    @objc func pushEdit(){
        let editViewController = EditViewController()
//        editViewController!.delegate = self
        navigationController?.pushViewController(editViewController, animated: true)
    }
    //addButton function
    @objc func add(){
        pushEdit()
    }
    
    
    
}
