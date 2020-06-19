//
//  JoinViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/16/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import Firebase

class JoinViewController: UIViewController {
    
    
    var roomlist: [Game]! = []
    
    var roomTableView: UITableView!
    
    let rid = "joinReuseIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgcolor
        self.navigationItem.title = "Join a game!"
        navigationController?.navigationBar.barTintColor = .customyellow
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        roomTableView = UITableView()
        roomTableView.backgroundColor = .bgcolor
        view.addSubview(roomTableView)
        
        
        roomTableView.register(JoinTableViewCell.self, forCellReuseIdentifier: rid)
        roomTableView.dataSource = self
        roomTableView.delegate = self
        
        listenForRoom()
        
        
        setup()
    }
    
    func setup(){
        roomTableView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    
    func listenForRoom(){
        //single or observe??
        DatabaseManager.ref.child("games").queryOrdered(byChild: "gameState").queryEqual(toValue: 0).observeSingleEvent(of: .value, with: { (snapshot) in
            if let gameDict = snapshot.value as? [String : Any]{
                //print(gameDict)
                gameDict.forEach { (hostID, gameObj) in
                    let game = Game.fromDatabase(object: gameObj as! [String : Any])
                    game.host = hostID
                    //print(game.id)
                    if game.host != Auth.auth().currentUser?.uid {
                        self.roomlist.append(game)
                        //print(self.roomlist)
                        self.roomTableView.reloadData()
                    }
                    
                }
                
            }
        })
    }
    
}


extension JoinViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(playerlist.count)
        return roomlist.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rid, for: indexPath) as! JoinTableViewCell
        let room = roomlist[indexPath.row]
        DatabaseManager.findPlayerByUid(uid: room.host) { (player) in
            cell.configure(with: player.name)
        }
        
        return cell
        
    }
    
}

extension JoinViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hostID = roomlist[indexPath.row].host
        let joinerID = Auth.auth().currentUser?.uid
        DatabaseManager.confirmJoin(hostID: hostID, joinerID: joinerID!)
        DatabaseManager.findPlayerByUid(uid: hostID){
            (player) in
            let startingVC = StartingViewController(opponent: player)
            self.navigationController?.pushViewController(startingVC, animated: true)
        }
        
    }
}








