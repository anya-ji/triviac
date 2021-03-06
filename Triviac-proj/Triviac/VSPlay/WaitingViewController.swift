//
//  WaitingViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/18/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import Firebase

class WaitingViewController: UIViewController {
    
    var waitingLabel: UILabel!
    var activityView: UIActivityIndicatorView!
    var cancelButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgcolor
        navigationController?.navigationBar.barTintColor = .accentbuttoncolor
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = self.view.center
        activityView.color = .white
        activityView.startAnimating()
        view.addSubview(activityView)
        
        waitingLabel = UILabel()
        waitingLabel.text = "Waiting for a player to join..."
        waitingLabel.textColor = .textcolor
        waitingLabel.font = UIFont.init(name: "Chalkduster", size: 25)
        waitingLabel.textAlignment = .center
        waitingLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(waitingLabel)
        
        waitingLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(activityView.snp.top).offset(-20)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        cancelButton = UIButton()
        view.addSubview(cancelButton)
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.backgroundColor = .black
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 30)
        cancelButton.titleLabel?.textAlignment = .center
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.borderWidth = 3
        cancelButton.layer.borderColor = UIColor.gray.cgColor
        applyShadow(button: cancelButton, shadow: .shadowcolor)
        
        let gap = view.frame.height / 83
        cancelButton.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-gap*5)
            make.height.equalTo(60)
            make.width.equalTo(150)
        }
        cancelButton.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        listenForStartGame()
        
    }
    
    @objc func cancel(){
        buttonAnimate(button: cancelButton, shadow: .shadowcolor)
        
        DatabaseManager.cancelInvite()
       
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    func listenForStartGame(){
        DatabaseManager.ref.child("games").child(DatabaseManager.currentGame.host).observe(.value) { (snapshot) in
            if let gameDict = snapshot.value as? [String: Any]{
                let game = Game.fromDatabase(object: gameDict)
                if game.gameState == 1{
                    DatabaseManager.ref.child("games").child(DatabaseManager.currentGame.host).removeAllObservers()
                    //need to remove observer! or it will come back here on every change
                    DatabaseManager.findPlayerByUid(uid: game.joiner){
                        (player) in
                        
                        DatabaseManager.opponent = player
                        
                        let startingVC = StartingViewController()
                        self.navigationController?.pushViewController(startingVC, animated: true)
                    }
                }
            }
        }
    }
    
}
