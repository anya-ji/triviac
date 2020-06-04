//
//  PlayViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import HTMLEntities


class PlayViewController: UIViewController {
    
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
    var rsLabel: UILabel!
    var quitButton: UIButton!
    var stateLabel: UILabel!
    
    var notfoundView: UIView!
    var ok: UIButton!
    var prompt: UILabel!
    
    var choices: [String] = []
    var aButton: UIButton!
    var bButton: UIButton!
    var cButton: UIButton!
    var dButton: UIButton!
    
    let gap: CGFloat = 30
    let padding: CGFloat = 8
    
    var triviaset = [Trivia]()
    var turnsleft: Int = 0
    
    var state: State!
    var mode: String!
    var replay: TriviaObj!
    
    init(mode: String, replay: TriviaObj?){
        super.init(nibName: nil, bundle: nil)
        self.mode = mode
        self.replay = replay
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
        
        rsLabel = UILabel()
        rsLabel.font = UIFont.init(name: "Helvetica", size: 40)
        rsLabel.textAlignment = .center
        view.addSubview(rsLabel)
        
        quitButton = UIButton()
        quitButton.setTitle("Quit", for: .normal)
        quitButton.setTitleColor(btcolor, for: .normal)
        quitButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
        quitButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        quitButton.titleLabel?.textAlignment = .center
        view.addSubview(quitButton)
        
        //not found
        notfoundView = UIView()
        notfoundView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        notfoundView.layer.cornerRadius = 10
        view.addSubview(notfoundView)
        notfoundView.isHidden = true
        
        ok = UIButton()
        ok.setTitle("OK", for: .normal)
        ok.backgroundColor = okcolor
        ok.setTitleColor(.white, for: .normal)
        ok.addTarget(self, action: #selector(quit), for: .touchUpInside)
        ok.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        ok.titleLabel?.textAlignment = .center
        ok.layer.cornerRadius = 15
        ok.layer.borderWidth = 1
        ok.layer.borderColor = UIColor.white.cgColor
        ok.titleLabel?.adjustsFontSizeToFitWidth = true
        ok.layer.shadowOpacity = 0.8
        ok.layer.shadowOffset = CGSize(width: 4, height: 4)
        ok.layer.shadowColor = UIColor.darkGray.cgColor
        notfoundView.addSubview(ok)
        
        
        prompt = UILabel()
        prompt.text = "Oops, the trivia doesn't exist.🤯 \nPlease try another combination."
        prompt.textColor = .white
        prompt.font = UIFont.init(name: "Chalkduster", size: 20)
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        notfoundView.addSubview(prompt)
        
        
        setup()
        getTrivia()
        
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
        
        rsLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-gap)
            make.height.width.equalTo(50)
        }
        
        
        qLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.bottom.equalTo(rsLabel.snp.top).offset(-gap)
        }
        quitButton.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        stateLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.top.equalTo(quitButton.snp.bottom)
        }
        
        
        notfoundView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.height.equalTo(220)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        ok.snp.makeConstraints{make in
            make.height.equalTo(40)
            make.width.equalTo(60)
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        ok.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        prompt.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(ok.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        

        
        if mode == "multiple"{
            aButton.snp.makeConstraints{make in
                make.top.equalTo(rsLabel.snp.bottom).offset(gap)
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

    
    @objc func quit(sender: UIButton){
        if sender == ok {
            buttonAnimate(button: ok, shadow: UIColor.darkGray)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
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
                rsLabel.text = "✅"
            }
            else {
                rsLabel.text = "❌"
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
                    self.rsLabel.text = ""
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
                rsLabel.text = "✅"
            }else{
                rsLabel.text = "❌"
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
                    self.rsLabel.text = ""
                    self.setToNormal(button: sender)
                    self.tButton.isEnabled = true
                    self.fButton.isEnabled = true
                }
            }
        }
    }
    
    func endGame(){
        var update = false
        if self.replay != nil {
            //find this triviaObj
            var data = self.userDefaults.array(forKey: "data") as? [Data] ?? []
            var i = 0
            let id = self.replay.id
            
            while i < data.count{
                let t = try? PropertyListDecoder().decode(TriviaObj.self, from: data[i])
                if  id == t?.id{
                    if Int(String((t?.score.prefix(1))!))! < self.state.correct {
                        data.remove(at: i)
                        update = true
                    }
                    break
                }
                i = i+1
            }
            if update {
                let triviaObj = TriviaObj.init(title: self.replay.title,set: self.replay.set, score: "\(self.state.correct) / \(self.state.all)")
            let setEncoded = try? PropertyListEncoder().encode(triviaObj)
            data.append(setEncoded!)
                self.userDefaults.set(data, forKey: "data")
            }
        }
        let endViewController = EndViewController(state: self.state, set: self.triviaset, exist: self.replay, update: update)
        self.navigationController?.pushViewController(endViewController, animated: true)
    }
    
    
    func getTrivia() {
        if replay != nil {
            triviaset = replay.set
            turnsleft = triviaset.count
            state = State.init(all: turnsleft)
            qLabel.text = triviaset[0].question.htmlUnescape()
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
        else {
            NetworkManager.getTrivia(){
                triviaset in
                if triviaset.isEmpty {
                    self.notfoundView.isHidden = false
                }
                else {
                    self.triviaset = triviaset
                    
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
        }
    }
    
}

