//
//  StartingViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/18/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {
    
    var myImageView: UIImageView!
    var myNameLabel: UILabel!
    
    var opImageView: UIImageView!
    var opNameLabel: UILabel!
    
    // instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    
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
        
        let currentPlayer = userDefaults.data(forKey: "currentPlayer")! as Data
        DatabaseManager.currentPlayer = try? PropertyListDecoder().decode(Player.self, from: currentPlayer)
        
        myImageView = UIImageView()
        myImageView.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        myImageView.backgroundColor = .clear
        myImageView.tintColor = UIColor.init(hex: DatabaseManager.currentPlayer.color)
        view.addSubview(myImageView)
        
        myNameLabel = UILabel()
        myNameLabel.textColor = .white
        myNameLabel.text = DatabaseManager.currentPlayer.name
        myNameLabel.font = UIFont.init(name: "Chalkduster", size: 25)
        myNameLabel.textAlignment = .left
        myNameLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(myNameLabel)
        
        opImageView = UIImageView()
        opImageView.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        opImageView.backgroundColor = .clear
        opImageView.tintColor = UIColor.init(hex: DatabaseManager.opponent.color)
        view.addSubview(opImageView)
        
        opNameLabel = UILabel()
        opNameLabel.textColor = .white
        opNameLabel.text = DatabaseManager.opponent.name
        opNameLabel.font = UIFont.init(name: "Chalkduster", size: 25)
        opNameLabel.textAlignment = .left
        opNameLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(opNameLabel)
        
        setup()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(startGame), userInfo: nil, repeats: false)
        //startGame()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myImageView.makeRounded()
        opImageView.makeRounded()
    }
    
    func setup(){
        myImageView.snp.makeConstraints{ make in
            make.height.width.equalTo(80)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.bottom.equalTo(view.snp.centerY).offset(-10)
        }
        
        myNameLabel.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.leading.equalTo(myImageView.snp.trailing).offset(10)
            make.centerY.equalTo(myImageView.snp.centerY)
        }
        
        opImageView.snp.makeConstraints{ make in
            make.height.width.equalTo(80)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.top.equalTo(view.snp.centerY).offset(10)
        }
        
        opNameLabel.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.trailing.equalTo(opImageView.snp.leading).offset(-10)
            make.centerY.equalTo(opImageView.snp.centerY)
        }
    }
    
    @objc func startGame(){
       // DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vsPlayVC = VSPlayViewController()
            self.navigationController?.pushViewController(vsPlayVC, animated: true)
       // }
    }
    
    
    
    
    
    
    
}
