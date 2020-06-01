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
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let btcolor = UIColor(red: 0.77, green: 0.76, blue: 0.78, alpha: 1.00)
    let slcolor = UIColor(red: 1.00, green: 0.75, blue: 0.27, alpha: 1.00)
    let correctcolor = UIColor(red: 0.54, green: 0.80, blue: 0.53, alpha: 1.00)
    let okcolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    
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
            aButton.backgroundColor = btcolor
            aButton.setTitleColor(.white, for: .normal)
            aButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
            aButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
            aButton.titleLabel?.adjustsFontSizeToFitWidth = true
            aButton.titleLabel?.textAlignment = .center
            aButton.layer.cornerRadius = 15
            aButton.layer.borderWidth = 1
            aButton.layer.borderColor = UIColor.white.cgColor
            view.addSubview(aButton)
            aButton.isHidden = true
            aButton.isEnabled = true
            aButton.titleLabel?.numberOfLines = 0
            
            bButton = UIButton()
            bButton.backgroundColor = btcolor
            bButton.setTitleColor(.white, for: .normal)
            bButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
            bButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
            bButton.titleLabel?.textAlignment = .center
            bButton.titleLabel?.adjustsFontSizeToFitWidth = true
            bButton.layer.cornerRadius = 15
            bButton.layer.borderWidth = 1
            bButton.layer.borderColor = UIColor.white.cgColor
            view.addSubview(bButton)
            bButton.isHidden = true
            bButton.isEnabled = true
            bButton.titleLabel?.numberOfLines = 0
            
            cButton = UIButton()
            cButton.backgroundColor = btcolor
            cButton.setTitleColor(.white, for: .normal)
            cButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
            cButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
            cButton.titleLabel?.textAlignment = .center
            cButton.titleLabel?.adjustsFontSizeToFitWidth = true
            cButton.layer.cornerRadius = 15
            cButton.layer.borderWidth = 1
            cButton.layer.borderColor = UIColor.white.cgColor
            view.addSubview(cButton)
            cButton.isHidden = true
            cButton.isEnabled = true
            cButton.titleLabel?.numberOfLines = 0
            
            dButton = UIButton()
            dButton.backgroundColor = btcolor
            dButton.setTitleColor(.white, for: .normal)
            dButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
            dButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
            dButton.titleLabel?.textAlignment = .center
            dButton.titleLabel?.adjustsFontSizeToFitWidth = true
            dButton.layer.cornerRadius = 15
            dButton.layer.borderWidth = 1
            dButton.layer.borderColor = UIColor.white.cgColor
            view.addSubview(dButton)
            dButton.isHidden = true
            dButton.isEnabled = true
            dButton.titleLabel?.numberOfLines = 0
            
        }
        else {
            tButton = UIButton()
            tButton.setTitle("T", for: .normal)
            tButton.backgroundColor = btcolor
            tButton.setTitleColor(.white, for: .normal)
            tButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
            tButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 50)
            tButton.titleLabel?.textAlignment = .center
            tButton.layer.cornerRadius = 15
            tButton.layer.borderWidth = 1
            tButton.layer.borderColor = UIColor.white.cgColor
            view.addSubview(tButton)
            tButton.isHidden = true
            tButton.isEnabled = true
            
            fButton = UIButton()
            fButton.setTitle("F", for: .normal)
            fButton.backgroundColor = btcolor
            fButton.setTitleColor(.white, for: .normal)
            fButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
            fButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 50)
            fButton.titleLabel?.textAlignment = .center
            fButton.layer.cornerRadius = 15
            fButton.layer.borderWidth = 1
            fButton.layer.borderColor = UIColor.white.cgColor
            view.addSubview(fButton)
            fButton.isHidden = true
            fButton.isEnabled = true
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
    
    func setup(){
        qLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.bottom.equalTo(view.snp.centerY).offset(-gap)
        }
        stateLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.bottom.equalTo(qLabel.snp.top)
        }
        
        quitButton.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(40)
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
        
        rsLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(50)
        }
        
        if mode == "multiple"{
            aButton.snp.makeConstraints{make in
                make.top.equalTo(rsLabel.snp.bottom).offset(gap)
                make.height.equalTo(40)
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
                make.top.equalTo(aButton.snp.bottom).offset(gap)
                make.height.equalTo(40)
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
                make.top.equalTo(bButton.snp.bottom).offset(gap)
                make.height.equalTo(40)
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
                make.top.equalTo(cButton.snp.bottom).offset(gap)
                make.height.equalTo(40)
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
    
    @objc func quit(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func sl(sender: UIButton){
        sender.backgroundColor = slcolor
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
                    aButton.backgroundColor = correctcolor
                } else if bButton.titleLabel?.text == correctans{
                    bButton.backgroundColor = correctcolor
                } else if cButton.titleLabel?.text == correctans{
                    cButton.backgroundColor = correctcolor
                } else{
                    dButton.backgroundColor = correctcolor
                }
            }
            turnsleft = turnsleft - 1
            
            let seconds = 2.0
            
            if turnsleft == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    let endViewController = EndViewController(state: self.state, set: self.triviaset, exist: self.replay)
                    self.navigationController?.pushViewController(endViewController, animated: true)
                }
            } else {
                let next = triviaset[self.triviaset.count - self.turnsleft]
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.qLabel.text = next.question.htmlUnescape()
                    self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
                    self.rsLabel.text = ""
                    sender.backgroundColor = self.btcolor
                    self.aButton.backgroundColor = self.btcolor
                    self.bButton.backgroundColor = self.btcolor
                    self.cButton.backgroundColor = self.btcolor
                    self.dButton.backgroundColor = self.btcolor
                    var c = next.incorrect_answers
                    c.append(next.correct_answer)
                    self.choices = c.map{ $0.htmlUnescape() }
                    self.choices.shuffle()
                    self.aButton.setTitle(self.choices[0], for: .normal)
                    self.bButton.setTitle(self.choices[1], for: .normal)
                    self.cButton.setTitle(self.choices[2], for: .normal)
                    self.dButton.setTitle(self.choices[3], for: .normal)
                    self.aButton.isEnabled = true
                    self.bButton.isEnabled = true
                    self.cButton.isEnabled = true
                    self.dButton.isEnabled = true
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
                    let endViewController = EndViewController(state: self.state, set: self.triviaset, exist: self.replay)
                    self.navigationController?.pushViewController(endViewController, animated: true)
                }
            } else {
                let next = triviaset[self.triviaset.count - self.turnsleft]
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.qLabel.text = next.question.htmlUnescape()
                    self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
                    self.rsLabel.text = ""
                    sender.backgroundColor = self.btcolor
                    self.tButton.isEnabled = true
                    self.fButton.isEnabled = true
                }
            }
        }
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

