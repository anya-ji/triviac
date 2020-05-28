//
//  EndViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/8/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var rsLabel: UILabel!
    var quitButton: UIButton!
    var saveButton: UIButton!
    
    let bgcolor = UIColor(red: 1.00, green: 0.75, blue: 0.27, alpha: 1.00)
    let gap = 10
    
    var score: Int!
    var total: Int!
    var set: [Trivia]!
    var exist: TriviaObj!
    
    // instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    
    init(state: State, set: [Trivia], exist: TriviaObj?){
        super.init(nibName: nil, bundle: nil)
        self.score = state.correct
        self.total = state.all
        self.set = set
        self.exist = exist
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgcolor
        
        
        rsLabel = UILabel()
        view.addSubview(rsLabel)
        rsLabel.lineBreakMode = .byWordWrapping
        rsLabel.text = "\(score!) / \(total!)"
        rsLabel.numberOfLines = 2
        rsLabel.textColor = .white
        rsLabel.font = UIFont.init(name: "Chalkduster", size: 80)
        rsLabel.textAlignment = .center
        rsLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(90)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
        }
        
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
            make.bottom.equalTo(rsLabel.snp.top).offset(-gap)
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
        }
        
        if exist == nil {
            saveButton = UIButton()
            view.addSubview(saveButton)
            saveButton.setTitle("Save", for: .normal)
            saveButton.backgroundColor = .lightGray
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
            saveButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 30)
            saveButton.titleLabel?.textAlignment = .center
            saveButton.layer.cornerRadius = 20
            saveButton.layer.borderWidth = 3
            saveButton.layer.borderColor = UIColor.gray.cgColor
            saveButton.snp.makeConstraints{ make in
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(rsLabel.snp.bottom).offset(gap*7)
                make.height.equalTo(60)
                make.width.equalTo(150)
            }
            saveButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
        }
        quitButton = UIButton()
        view.addSubview(quitButton)
        quitButton.setTitle("Quit", for: .normal)
        quitButton.backgroundColor = .black
        quitButton.setTitleColor(.white, for: .normal)
        quitButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
        quitButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 30)
        quitButton.titleLabel?.textAlignment = .center
        quitButton.layer.cornerRadius = 20
        quitButton.layer.borderWidth = 3
        quitButton.layer.borderColor = UIColor.gray.cgColor
        quitButton.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            if exist != nil{
                make.top.equalTo(rsLabel.snp.bottom).offset(gap*7)
            } else{
                make.top.equalTo(saveButton.snp.bottom).offset(gap*2)
            }
            make.height.equalTo(60)
            make.width.equalTo(150)
        }
        quitButton.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
    }
    
    @objc func quit(){
        if exist != nil {
            //find this triviaObj
            var data = userDefaults.array(forKey: "data") as? [Data] ?? []
            var i = 0
            let id = exist.id
            var update = false
            while i < data.count{
                let t = try? PropertyListDecoder().decode(TriviaObj.self, from: data[i])
                if  id == t?.id{
                    if Int(String((t?.score.prefix(1))!))! < score! {
                        data.remove(at: i)
                        update = true
                    }
                    break
                }
                i = i+1
            }
            if update {
            let triviaObj = TriviaObj.init(set: set, score: "\(score!) / \(total!)")
            let setEncoded = try? PropertyListEncoder().encode(triviaObj)
            data.append(setEncoded!)
            userDefaults.set(data, forKey: "data")
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc func save(){
        let triviaObj = TriviaObj.init(set: set, score: "\(score!) / \(total!)")
        var data = userDefaults.array(forKey: "data") as? [Data] ?? []
        let setEncoded = try? PropertyListEncoder().encode(triviaObj)
        data.append(setEncoded!)
        //print(data)
        userDefaults.set(data, forKey: "data")
        userDefaults.set(Date(), forKey: "lastUpdated")
        navigationController?.popToRootViewController(animated: true)
    }
}
