//
//  EndViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/8/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

protocol getStateDelegate: class {
    func getState(state: State)
}

class EndViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var rsLabel: UILabel!
    var quitButton: UIButton!
    
    let bgcolor = UIColor(red: 1.00, green: 0.75, blue: 0.27, alpha: 1.00)
    let gap = 20
    
    var score: Int!
    var total: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgcolor
        
        scoreLabel = UILabel()
        view.addSubview(scoreLabel)
        scoreLabel.text = "You \n Scored:"
        scoreLabel.lineBreakMode = .byWordWrapping
        scoreLabel.numberOfLines = 2
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.init(name: "Chalkduster", size: 40)
        scoreLabel.textAlignment = .center
        scoreLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(gap)
            make.bottom.equalTo(view.snp.centerY).offset(-gap)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
        }
        
        
        rsLabel = UILabel()
        view.addSubview(rsLabel)
        rsLabel.lineBreakMode = .byWordWrapping
        rsLabel.numberOfLines = 2
        rsLabel.textColor = .white
        rsLabel.font = UIFont.init(name: "Chalkduster", size: 80)
        rsLabel.textAlignment = .center
        rsLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(gap)
            make.height.equalTo(90)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
        }
        
        quitButton = UIButton()
        view.addSubview(quitButton)
        quitButton.setTitle("Quit", for: .normal)
        quitButton.backgroundColor = .black
        quitButton.setTitleColor(.white, for: .normal)
        quitButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
        quitButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 50)
        quitButton.titleLabel?.textAlignment = .center
        quitButton.layer.cornerRadius = 20
        quitButton.layer.borderWidth = 3
        quitButton.layer.borderColor = UIColor.gray.cgColor
        quitButton.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalToSuperview().offset(-gap*5)
            make.height.equalTo(100)
            make.width.equalTo(150)
        }
        
    }
    

@objc func quit(){
    navigationController?.popToRootViewController(animated: true)
}
}
extension EndViewController: getStateDelegate{
    func getState(state: State) {
        PlayViewController().delegate = self
        self.score = state.correct
        self.total = state.all
        //rsLabel.text = "\(self.score) / \(self.total)"
    }
}
