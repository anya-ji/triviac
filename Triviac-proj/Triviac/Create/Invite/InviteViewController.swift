//
//  InviteViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/9/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {
    
    var mode: String!
    var replay: TriviaObj!
    var add: String!
    
    var playerlist: [Player]!
    
    var addedTableView: UITableView!
    var
    
    init(mode: String, replay: TriviaObj?, add: String){
           super.init(nibName: nil, bundle: nil)
           self.mode = mode
           self.replay = replay
            self.add = add
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setup()
    }
    
    

}



