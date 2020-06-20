//
//  PlayViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import HTMLEntities


class VSPlayViewController: UIViewController {
    
    // instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let btcolor = UIColor(red: 0.77, green: 0.76, blue: 0.78, alpha: 1.00)
    let slcolor = UIColor(red: 1.00, green: 0.75, blue: 0.27, alpha: 1.00)
    let correctcolor = UIColor(red: 0.54, green: 0.80, blue: 0.53, alpha: 1.00)
    let okcolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    let borderslcolor = UIColor(red: 0.93, green: 0.54, blue: 0.20, alpha: 1.00)
    let bordercorrectcolor = UIColor(red: 0.45, green: 0.76, blue: 0.44, alpha: 1.00)
    let shadowcolor = UIColor(red: 0.15, green: 0.16, blue: 0.16, alpha: 1.00)
    
    var qLabel: UILabel!
    var tButton: UIButton!
    var fButton: UIButton!
    //var rsLabel: UILabel!
    //var quitButton: UIButton!
    var stateLabel: UILabel!
    
    var choices: [String] = []
    var aButton: UIButton!
    var bButton: UIButton!
    var cButton: UIButton!
    var dButton: UIButton!
    
    let gap: CGFloat = 30
    let padding: CGFloat = 8
    
    var triviaset: [Trivia]!
    var turnsleft: Int = 0
    
    var opponent: Player!
    var currentPlayer: Player!
    
    var myImageView: UIImageView!
    var myrsLabel: UILabel!
    var opImageView: UIImageView!
    var oprsLabel: UILabel!
    
    var state: State!
    var mode: String!
    
    init(opponent: Player){
        super.init(nibName: nil, bundle: nil)
        let chosentyp = DatabaseManager.currentGame.triviaset[0].type
        self.mode = chosentyp
        self.opponent = opponent
        let currentPlayerData = userDefaults.data(forKey: "currentPlayer")! as Data
        self.currentPlayer = try? PropertyListDecoder().decode(Player.self, from: currentPlayerData)
        self.triviaset = DatabaseManager.currentGame.triviaset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //hide navigation bar & tab
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgcolor
        
        qLabel = UILabel()
        qLabel.textColor = .white
        qLabel.font = UIFont.init(name: "Chalkduster", size: 20)
        qLabel.lineBreakMode = .byWordWrapping
        qLabel.numberOfLines = 0
        qLabel.textAlignment = .center
        qLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(qLabel)
        
        stateLabel = UILabel()
        stateLabel.textColor = .white
        stateLabel.font = UIFont.init(name: "Chalkduster", size: 15)
        stateLabel.lineBreakMode = .byWordWrapping
        stateLabel.numberOfLines = 0
        stateLabel.textAlignment = .center
        view.addSubview(stateLabel)
        
        if mode == "multiple" {
            aButton = UIButton()
            bButton = UIButton()
            cButton = UIButton()
            dButton = UIButton()
            mcButtonSetUp(button: aButton)
            mcButtonSetUp(button: bButton)
            mcButtonSetUp(button: cButton)
            mcButtonSetUp(button: dButton)
            
        }
        else {
            tButton = UIButton()
            tButton.setTitle("T", for: .normal)
            fButton = UIButton()
            fButton.setTitle("F", for: .normal)
            tfButtonSetUp(button: tButton)
            tfButtonSetUp(button: fButton)
        }
        
        //        rsLabel = UILabel()
        //        rsLabel.font = UIFont.init(name: "Helvetica", size: 40)
        //        rsLabel.textAlignment = .center
        //        view.addSubview(rsLabel)
        
        //        quitButton = UIButton()
        //        quitButton.setTitle("Quit", for: .normal)
        //        quitButton.setTitleColor(btcolor, for: .normal)
        //        quitButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
        //        quitButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        //        quitButton.titleLabel?.textAlignment = .center
        //        view.addSubview(quitButton)
        
        //score board
        myImageView = UIImageView()
        myImageView.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        myImageView.backgroundColor = .clear
        myImageView.tintColor = UIColor.init(hex: currentPlayer.color)
        view.addSubview(myImageView)
        
        myrsLabel = UILabel()
        myrsLabel.font = UIFont.init(name: "Chalkduster", size: 30)
        myrsLabel.textAlignment = .center
        view.addSubview(myrsLabel)
        
        opImageView = UIImageView()
        opImageView.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        opImageView.backgroundColor = .clear
        opImageView.tintColor = UIColor.init(hex: opponent.color)
        view.addSubview(opImageView)
        
        oprsLabel = UILabel()
        oprsLabel.font = UIFont.init(name: "Chalkduster", size: 30)
        oprsLabel.textAlignment = .center
        view.addSubview(oprsLabel)
        
        setup()
        getTrivia()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myImageView.makeRounded()
        opImageView.makeRounded()
    }
    
    func mcButtonSetUp(button: UIButton) -> Void{
        button.backgroundColor = btcolor
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(sl), for: .touchUpInside)
        button.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isHidden = true
        button.isEnabled = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.minimumScaleFactor = 0.7
        button.layer.shadowColor = shadowcolor.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.addSubview(button)
        
    }
    func tfButtonSetUp(button: UIButton) -> Void{
        button.backgroundColor = btcolor
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(sl), for: .touchUpInside)
        button.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 50)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isHidden = true
        button.isEnabled = true
        button.layer.shadowColor = shadowcolor.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.addSubview(button)
    }
    
    func setup(){
        
        //        rsLabel.snp.makeConstraints{ make in
        //            make.centerX.equalToSuperview()
        //            make.centerY.equalToSuperview().offset(-gap)
        //            make.height.width.equalTo(50)
        //        }
        
        //        quitButton.snp.makeConstraints{make in
        //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        //            make.leading.equalToSuperview().offset(20)
        //            make.height.equalTo(30)
        //            make.width.equalTo(40)
        //        }
        stateLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        
        myImageView.snp.makeConstraints{ make in
            make.height.width.equalTo(40)
            make.top.equalTo(stateLabel.snp.bottom).offset(gap)
            make.trailing.equalTo(view.snp.centerX).offset(-gap)
        }
        
        myrsLabel.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.leading.equalTo(myImageView.snp.trailing).offset(20)
            make.centerY.equalTo(myImageView.snp.centerY)
        }
        
        opImageView.snp.makeConstraints{ make in
            make.height.width.equalTo(40)
            make.top.equalTo(myImageView.snp.bottom).offset(gap)
            make.trailing.equalTo(view.snp.centerX).offset(-gap)
        }
        
        oprsLabel.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.leading.equalTo(opImageView.snp.trailing).offset(20)
            make.centerY.equalTo(opImageView.snp.centerY)
        }
        
        qLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.top.equalTo(oprsLabel.snp.bottom).offset(gap)
        }
        
        if mode == "multiple"{
            aButton.snp.makeConstraints{make in
                make.top.equalTo(qLabel.snp.bottom).offset(gap)
                make.height.equalTo(60)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            aButton.titleLabel?.snp.makeConstraints{ make in
                //make.centerY.equalToSuperview().offset(-3)
                make.top.equalToSuperview().offset(4)
                make.bottom.equalToSuperview().offset(-8)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
            }
            
            bButton.snp.makeConstraints{make in
                make.top.equalTo(aButton.snp.bottom).offset(padding)
                make.height.equalTo(60)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            bButton.titleLabel?.snp.makeConstraints{ make in
                //make.centerY.equalToSuperview().offset(-3)
                make.top.equalToSuperview().offset(4)
                make.bottom.equalToSuperview().offset(-8)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
            }
            
            cButton.snp.makeConstraints{make in
                make.top.equalTo(bButton.snp.bottom).offset(padding)
                make.height.equalTo(60)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            cButton.titleLabel?.snp.makeConstraints{ make in
                //make.centerY.equalToSuperview().offset(-3)
                make.top.equalToSuperview().offset(4)
                make.bottom.equalToSuperview().offset(-8)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
            }
            
            dButton.snp.makeConstraints{make in
                make.top.equalTo(cButton.snp.bottom).offset(padding)
                make.height.equalTo(60)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            dButton.titleLabel?.snp.makeConstraints{ make in
                //make.centerY.equalToSuperview().offset(-3)
                make.top.equalToSuperview().offset(4)
                make.bottom.equalToSuperview().offset(-8)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
            }
        }
        else
        {
            tButton.snp.makeConstraints{make in
                make.top.equalTo(view.snp.centerY).offset(gap*3)
                make.height.equalTo(80)
                make.width.equalTo(120)
                make.leading.equalToSuperview().offset((view.frame.width - 2*120)/4)
            }
            tButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
            fButton.snp.makeConstraints{make in
                make.top.equalTo(view.snp.centerY).offset(gap*3)
                make.height.equalTo(80)
                make.width.equalTo(120)
                make.trailing.equalToSuperview().offset(-(view.frame.width - 2*120)/4)
            }
            fButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
        }
        
        
        
    }
    
    
    //    @objc func quit(sender: UIButton){
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
    //            self.navigationController?.popToRootViewController(animated: true)
    //        }
    //    }
    
    func setToNormal(button: UIButton) -> Void{
        button.transform = CGAffineTransform.identity
        button.backgroundColor = btcolor
        button.isEnabled = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = shadowcolor.cgColor
    }
    
    func setToSelected(button: UIButton) -> Void{
        button.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        button.backgroundColor = slcolor
        button.layer.borderWidth = 3
        button.layer.borderColor = borderslcolor.cgColor
        button.layer.shadowColor = UIColor.clear.cgColor
    }
    func setToCorrect(button: UIButton) -> Void{
        button.backgroundColor = correctcolor
        button.layer.borderWidth = 3
        button.layer.borderColor = bordercorrectcolor.cgColor
        button.layer.shadowColor = UIColor.clear.cgColor
    }
    
    @objc func sl(sender: UIButton){
        setToSelected(button: sender)
        let current = triviaset[self.triviaset.count - self.turnsleft]
        //update state
        if mode == "multiple"{
            aButton.isEnabled = false
            bButton.isEnabled = false
            cButton.isEnabled = false
            dButton.isEnabled = false
            let correctans = current.correct_answer.htmlUnescape()
            let yourans = sender.titleLabel?.text
            if correctans == yourans {
                state.update_correct()
                myrsLabel.text = "🤓"
            }
            else {
                myrsLabel.text = "🤯"
                if aButton.titleLabel?.text == correctans{
                    setToCorrect(button: aButton)
                } else if bButton.titleLabel?.text == correctans{
                    setToCorrect(button: bButton)
                } else if cButton.titleLabel?.text == correctans{
                    setToCorrect(button: cButton)
                } else{
                    setToCorrect(button: dButton)
                }
            }
            turnsleft = turnsleft - 1
            
            let seconds = 2.0
            
            if turnsleft == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.endGame()
                }
            } else {
                let next = triviaset[self.triviaset.count - self.turnsleft]
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.qLabel.text = next.question.htmlUnescape()
                    self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
                    self.myrsLabel.text = ""
                    self.setToNormal(button: self.aButton)
                    self.setToNormal(button: self.bButton)
                    self.setToNormal(button: self.cButton)
                    self.setToNormal(button: self.dButton)
                    var c = next.incorrect_answers
                    c.append(next.correct_answer)
                    self.choices = c.map{ $0.htmlUnescape() }
                    self.choices.shuffle()
                    self.aButton.setTitle(self.choices[0], for: .normal)
                    self.bButton.setTitle(self.choices[1], for: .normal)
                    self.cButton.setTitle(self.choices[2], for: .normal)
                    self.dButton.setTitle(self.choices[3], for: .normal)
                }
            }
        }
        else
        {
            tButton.isEnabled = false
            fButton.isEnabled = false
            let correctans = current.correct_answer == "True" ? true : false
            let yourans = sender.titleLabel?.text == "T" ? true : false
            if correctans == yourans {
                state.update_correct()
                myrsLabel.text = "🤓"
            }else{
                myrsLabel.text = "🤯"
            }
            
            turnsleft = turnsleft - 1
            
            let seconds = 2.0
            if turnsleft == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.endGame()
                }
            } else {
                let next = triviaset[self.triviaset.count - self.turnsleft]
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.qLabel.text = next.question.htmlUnescape()
                    self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
                    self.myrsLabel.text = ""
                    self.setToNormal(button: sender)
                    self.tButton.isEnabled = true
                    self.fButton.isEnabled = true
                }
            }
        }
    }
    
    func endGame(){
        
        
    }
    
    
    func getTrivia() {
    
            self.turnsleft = self.triviaset.count
            self.state = State.init(all: self.turnsleft)
            self.qLabel.text = self.triviaset[0].question.htmlUnescape()
            self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
            //mc
            if self.mode == "multiple"{
                var c = self.triviaset[0].incorrect_answers
                c.append(self.triviaset[0].correct_answer)
                self.choices = c.map{ $0.htmlUnescape() }
                self.choices.shuffle()
                self.aButton.isHidden = false
                self.bButton.isHidden = false
                self.cButton.isHidden = false
                self.dButton.isHidden = false
                self.aButton.setTitle(self.choices[0], for: .normal)
                self.bButton.setTitle(self.choices[1], for: .normal)
                self.cButton.setTitle(self.choices[2], for: .normal)
                self.dButton.setTitle(self.choices[3], for: .normal)
            }
            else {
                self.tButton.isHidden = false
                self.fButton.isHidden = false
            }
    }
}


