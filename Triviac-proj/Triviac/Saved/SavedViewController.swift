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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 1.00, green: 0.89, blue: 0.71, alpha: 1.00)
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
