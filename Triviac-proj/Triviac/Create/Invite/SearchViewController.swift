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
    
    let ref = Database.database().reference(fromURL: "https://triviac-63843.firebaseio.com/")
    
    var results: [Player]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.placeholder = "Search by username"
        searchBar.barStyle = .default
        view.addSubview(searchBar)
        
        resultsTableView = UITableView()
        resultsTableView.dataSource = self
        resultsTableView.register(ResultTableViewCell.self, forCellReuseIdentifier: rid)
        //resultsTableView.tableFooterView = UIView()
        resultsTableView.rowHeight = 50
        view.addSubview(resultsTableView)
        
        setup()
    }
    
    func setup() {
        searchBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
//            make.top.equalToSuperview().offset(navigationController!.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height)
            make.top.equalToSuperview()
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func update(with results: [String]) {
        self.results = results
        resultsTableView.reloadData()
    }
    
    func search(with input: String) {
        DatabaseManager.findUsers(input: input) { users in
            DispatchQueue.main.async {
                self.update(with: users)
            }
        }
    }


}

extension SearchViewController: UISearchBarDelegate {
    func findUsers(input: String, completion: @escaping ([String]) -> Void) {
        ref.child("users").queryOrdered(byChild: "name").queryStarting(atValue: input).queryEnding(atValue: "\(input)\u{f88f}").observeSingleEvent(of: .value){ snapshot in
            if let usersDict = snapshot.value as? [String: Any]{
                let results = usersDict.map {(name, player) in Player.fromDatabase(object: player)}
                completion(results.filter{System.isNew(user: $0)})
                return
            }
            completion([])
        }
        //find the closest to what u typed in; filter out yourself
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        search(with: text)
    }
    
}

extension SearchViewController: ResultTableViewCellDelegate {
    func resultTableViewCellDidTapAddButton(result: Player) {
        //
    }
    
    
//    func resultTableViewCellDidTapAddButton(result: String) {
//        DatabaseManager.addFriend(friend: result) { didCreate in
//            if didCreate {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: resultsReuseIdentifier, for: indexPath) as! ResultTableViewCell
        let result = results[indexPath.row]
        cell.configure(with: result, delegate: self)
        cell.selectionStyle = .none
        return cell
    }
    
}
