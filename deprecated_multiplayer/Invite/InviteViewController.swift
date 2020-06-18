//
//  InviteViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/9/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import Firebase

class InviteViewController: UIViewController {
    
    var mode: String!
    var replay: TriviaObj!
    
    var playerlist: [Player]! = []
    var acceptedlist: [Bool] = []
    
    var addedTableView: UITableView!
    var send: UIButton!
    var addButton: UIBarButtonItem!
    
    let rid = "inviteReuseIdentifier"
    
    init(mode: String, replay: TriviaObj?){
           super.init(nibName: nil, bundle: nil)
           self.mode = mode
           self.replay = replay
            
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgcolor
        self.navigationItem.title = "Invite"
        navigationController?.navigationBar.barTintColor = .customyellow
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearch))
        self.navigationItem.rightBarButtonItem = addButton
        
        addedTableView = UITableView()
        addedTableView.backgroundColor = .bgcolor
        view.addSubview(addedTableView)
        

        addedTableView.register(InviteTableViewCell.self, forCellReuseIdentifier: rid)
        addedTableView.dataSource = self
        addedTableView.delegate = self
        
        send = UIButton()
        send.setTitle("Invite", for: .normal)
        send.backgroundColor = .customyellow
        send.setTitleColor(.white, for: .normal)
        send.addTarget(self, action: #selector(sendInvitations), for: .touchUpInside)
        send.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 25)
        send.titleLabel?.textAlignment = .center
        send.layer.cornerRadius = 20
        send.layer.borderWidth = 3
        send.layer.borderColor = UIColor.white.cgColor
        send.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: send, shadow: .shadowcolor)
        view.addSubview(send)
        
        listenJoining()
        
        setup()
    }
    
    func setup(){
        let gap = view.frame.height / 83
        
        addedTableView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        send.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-gap*5)
            //make.top.equalTo(typ.snp.bottom).offset(gap*3)
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        send.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
    }
    
    func listenJoining() {
        if DatabaseManager.currentGameID != ""{
            /*https://stackoverflow.com/questions/43496922/snapshot-returned-from-firebase-database-event-childchanged-on-ios */
        DatabaseManager.ref.child("games").child(DatabaseManager.currentGameID).child("joiners").observe(.childChanged) { (snapshot) in
            let acceptedJoinerID = snapshot.key
            var acceptedJoinerName = ""
            DatabaseManager.findPlayerNameByUid(uid: acceptedJoinerID) { (name) in
                acceptedJoinerName = name
               let acceptedIndex = self.playerlist.firstIndex(where: {$0.name == acceptedJoinerName})
                self.acceptedlist[acceptedIndex!] = true
                self.addedTableView.reloadData()
        }
        }
    }
    }
    
    @objc func sendInvitations(){
        buttonAnimate(button: send, shadow: .shadowcolor)
//        let playViewController = PlayViewController(mode: mode, replay: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.navigationController?.pushViewController(playViewController, animated: true)
//        }
        if playerlist.isEmpty {
            return
        }
        let host = Auth.auth().currentUser?.uid
        let joinerslist = playerlist.map({$0.uid!})
        let joiners = joinerslist.reduce(into: [String: Int]()) { $0[$1] = -1 }
        let newGame = Game.init(host: host!, joiners: joiners, gameState: 0)
        DatabaseManager.createGame(game: newGame)
    }
    
    @objc func pushSearch(){
        let searchVC = SearchViewController(fromVC: self)
        present(searchVC, animated: true, completion: nil)
    }

}

extension InviteViewController: ResultTableViewCellDelegate {
    func resultTableViewCellDidTapAddButton(result: Player) {
        playerlist.append(result)
        acceptedlist.append(false)
        addedTableView.reloadData()
    }
    
}

extension InviteViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(playerlist.count)
        return playerlist.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rid, for: indexPath) as! InviteTableViewCell
        let player = playerlist[indexPath.row]
        let hasAccepted = acceptedlist[indexPath.row]
        
        cell.configure(with: player.name, accepted: hasAccepted)
        
        return cell
        
    }
    
    
    
}

extension InviteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



