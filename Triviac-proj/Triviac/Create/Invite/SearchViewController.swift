//
//  SearchViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/9/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {

    var searchBar: UISearchBar!
    var resultsTableView: UITableView!
    
    let rid = "resultsReuseIdentifier"
    
    var fromVC: InviteViewController!
    
    let ref = Database.database().reference(fromURL: "https://triviac-63843.firebaseio.com/")
    
    var results: [Player]! = []
    
    // Instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    
    init(fromVC: InviteViewController){
        super.init(nibName: nil, bundle: nil)
        self.fromVC = fromVC
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .customyellow
        view.backgroundColor = .bgcolor

        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.backgroundColor = .customyellow
        searchBar.barTintColor = .customyellow
        searchBar.placeholder = "Search by username"
        searchBar.barStyle = .black
        searchBar.isTranslucent = true
        view.addSubview(searchBar)
        
        resultsTableView = UITableView()
        resultsTableView.dataSource = self
        resultsTableView.backgroundColor = .bgcolor
        resultsTableView.register(ResultTableViewCell.self, forCellReuseIdentifier: rid)
        resultsTableView.rowHeight = 50
        view.addSubview(resultsTableView)
        
        setup()
    }
    
    func setup() {
        searchBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(70)
            make.top.equalToSuperview()
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func update(with results: [Player]) {
        self.results = results
        resultsTableView.reloadData()
    }
    
    func search(with input: String) {
        findUsers(input: input) { users in
            DispatchQueue.main.async {
                self.update(with: users)
            }
        }
    }


}

extension SearchViewController: UISearchBarDelegate {
    func findUsers(input: String, completion: @escaping ([Player]) -> Void) {
        ref.child("users").queryOrdered(byChild: "name").queryStarting(atValue: input).queryEnding(atValue: "\(input)\u{f88f}").observeSingleEvent(of: .value){ snapshot in
            if let usersDict = snapshot.value as? [String: Any]{
                let results = usersDict.map { (arg) -> Player in let (_ , player) = arg; return Player.fromDatabase(object: player as! [String : Any])}
                completion(results.filter{self.userDefaults.string(forKey: "currentPlayerName") != $0.name})
                return
            }
            completion([])
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text!.isEmpty {
            update(with: [])
        }
        else{
            search(with: searchBar.text!)
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: rid, for: indexPath) as! ResultTableViewCell
        let result = results[indexPath.row]
        cell.configure(with: result, delegate: fromVC)
        cell.selectionStyle = .none
        return cell
    }
    
}
