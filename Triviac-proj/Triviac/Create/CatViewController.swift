//
//  CatViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {
    var tableView: UITableView!
    let rid = "rid"
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    
    //delegate
    weak var delegate: CatChangeTextDelegate?
    
    //initialization
    init?(placeholder: String){
        //self.placeholder = placeholder
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgcolor
        
        tableView = UITableView()
        tableView.backgroundColor = bgcolor
        view.addSubview(tableView)
        tableView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        tableView.register(CatTableViewCell.self, forCellReuseIdentifier: "rid")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
}

extension CatViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CreateViewController.catarr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rid, for: indexPath) as! CatTableViewCell
        let cat = CreateViewController.catarr[indexPath.row]
        
        cell.config(for: cat)
        
        cell.selectionStyle = .gray
        
        return cell
        
    }
    
    
    
}

extension CatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.catTextChanged(to: CreateViewController.catarr[indexPath.row])
        
        dismiss(animated: true, completion: nil)
    }
}


