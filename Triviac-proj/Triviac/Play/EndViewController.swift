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
    
    let gap = 10
    
    var score: Int!
    var total: Int!
    var set: [Trivia]!
    var exist: TriviaObj!
    var update: Bool!
    
    var enterView: UIView!
    var saveName: UIButton!
    var cancelName: UIButton!
    var prompt: UILabel!
    var nameText: UITextField!
    
//    var congrat: UILabel!
    
    // instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    
    init(state: State, set: [Trivia], exist: TriviaObj?, update: Bool){
        super.init(nibName: nil, bundle: nil)
        self.score = state.correct
        self.total = state.all
        self.set = set
        self.exist = exist
        self.update = update
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgcolor
        hideKeyboardWhenTappedAround()
        
        rsLabel = UILabel()
        view.addSubview(rsLabel)
        rsLabel.lineBreakMode = .byWordWrapping
        rsLabel.text = "\(score!) / \(total!)"
        rsLabel.numberOfLines = 2
        rsLabel.textColor = .white
        rsLabel.font = UIFont.init(name: "Chalkduster", size: 80)
        rsLabel.textAlignment = .center
        
        
        scoreLabel = UILabel()
        view.addSubview(scoreLabel)
        if update {
            scoreLabel.text = "🎉 Congrats! 🎉 \nNew highest score:"
            scoreLabel.textColor = .orange
        } else{
        scoreLabel.text = "You \n Scored:"
            scoreLabel.textColor = .white
        }
        scoreLabel.lineBreakMode = .byWordWrapping
        scoreLabel.numberOfLines = 0
        scoreLabel.font = UIFont.init(name: "Chalkduster", size: 40)
        scoreLabel.textAlignment = .center
        scoreLabel.adjustsFontSizeToFitWidth = true
        
        
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
            applyShadow(button: saveButton, shadow: .shadowcolor)
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
        applyShadow(button: quitButton, shadow: .shadowcolor)
        
        
        //not found, name a new one
        enterView = UIView()
        enterView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        enterView.layer.cornerRadius = 10
        view.addSubview(enterView)
        enterView.isHidden = true
        
        saveName = UIButton()
        saveName.setTitle("OK", for: .normal)
        saveName.backgroundColor = .accentbuttoncolor
        saveName.setTitleColor(.white, for: .normal)
        saveName.addTarget(self, action: #selector(done), for: .touchUpInside)
        saveName.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        saveName.titleLabel?.textAlignment = .center
        saveName.layer.cornerRadius = 15
        saveName.layer.borderWidth = 1
        saveName.layer.borderColor = UIColor.white.cgColor
        saveName.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: saveName, shadow: .gray)
        enterView.addSubview(saveName)
        
        cancelName = UIButton()
        cancelName.setTitle("Cancel", for: .normal)
        cancelName.backgroundColor = .lightGray
        cancelName.setTitleColor(.white, for: .normal)
        cancelName.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelName.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        cancelName.titleLabel?.textAlignment = .center
        cancelName.layer.cornerRadius = 15
        cancelName.layer.borderWidth = 1
        cancelName.layer.borderColor = UIColor.white.cgColor
        cancelName.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: cancelName, shadow: .gray)
        enterView.addSubview(cancelName)
        
        prompt = UILabel()
        prompt.text = "Enter a name for the trivia:"
        prompt.textColor = .white
        prompt.font = UIFont.init(name: "Chalkduster", size: 20)
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        enterView.addSubview(prompt)
        
        nameText = UITextField()
        nameText.backgroundColor = .white
        nameText.placeholder = "Triviac"
        nameText.textColor = .black
        nameText.borderStyle = UITextField.BorderStyle.roundedRect
        nameText.textAlignment = .center
        nameText.font = UIFont.init(name: "ChalkboardSE-Regular", size: 30)
        nameText.textAlignment = .center
        nameText.adjustsFontSizeToFitWidth = true
        enterView.addSubview(nameText)
        
        
        setup()
    }
    
    func setup(){
        rsLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(90)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
        }
        
        scoreLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(rsLabel.snp.top).offset(-gap)
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
        }
        
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
        
        enterView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.height.equalTo(220)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        prompt.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        nameText.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(prompt.snp.bottom).offset(gap)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        saveName.snp.makeConstraints{make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalTo(view.snp.centerX).offset(-20)
        }
        saveName.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        cancelName.snp.makeConstraints{make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalTo(view.snp.centerX).offset(20)
        }
        cancelName.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
//        if update{
//            congrat.snp.makeConstraints{ make in
//                make.bottom.equalTo(scoreLabel.snp.top)
//                make.height.equalTo(50)
//                make.leading.equalToSuperview().offset(20)
//                make.trailing.equalToSuperview().offset(-20)
//            }
//        }
        
    }

    
    @objc func cancel(sender: UIButton){
        buttonAnimate(button: sender, shadow: .gray)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.enterView.isHidden = true
            self.quitButton.isEnabled = true
            self.saveButton.isEnabled = true
            self.view.endEditing(true)
        }
    }
    
    @objc func done(sender: UIButton){
        buttonAnimate(button: sender, shadow: .gray)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let triviaObj = TriviaObj.init(title: self.nameText.text ?? "Triviac", set: self.set, score: "\(self.score!) / \(self.total!)")
            var data = self.userDefaults.array(forKey: "data") as? [Data] ?? []
            let setEncoded = try? PropertyListEncoder().encode(triviaObj)
            data.append(setEncoded!)
            self.userDefaults.set(data, forKey: "data")
            self.userDefaults.set(Date(), forKey: "lastUpdated")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func quit(sender: UIButton){
        buttonAnimate(button: sender, shadow: .shadowcolor)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    @objc func save(sender: UIButton){
        buttonAnimate(button: sender, shadow: .shadowcolor)
        self.enterView.isHidden = false
        quitButton.isEnabled = false
        saveButton.isEnabled = false
    }
}
