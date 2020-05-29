//
//  PlayViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit


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
        //        getTrivia()
        
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
        
        if mode == "multiple"{
            aButton.snp.makeConstraints{make in
                make.top.equalTo(view.snp.centerY).offset(gap*2.5)
                make.height.equalTo(40)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            aButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
            bButton.snp.makeConstraints{make in
                make.top.equalTo(aButton.snp.bottom).offset(gap)
                make.height.equalTo(40)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            bButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
            cButton.snp.makeConstraints{make in
                make.top.equalTo(bButton.snp.bottom).offset(gap)
                make.height.equalTo(40)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            cButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
            dButton.snp.makeConstraints{make in
                make.top.equalTo(cButton.snp.bottom).offset(gap)
                make.height.equalTo(40)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
            }
            dButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
        }
        else
        {
            tButton.snp.makeConstraints{make in
                make.top.equalTo(view.snp.centerY).offset(gap*3)
                make.height.equalTo(80)
                make.width.equalTo(120)
                make.leading.equalToSuperview().offset(gap*1.5)
            }
            tButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
            fButton.snp.makeConstraints{make in
                make.top.equalTo(view.snp.centerY).offset(gap*3)
                make.height.equalTo(80)
                make.width.equalTo(120)
                make.trailing.equalToSuperview().offset(-gap*1.5)
            }
            fButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
        }
        
        rsLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(50)
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
            let correctans = current.correct_answer
            let yourans = sender.titleLabel?.text
            if correctans == yourans {
                state.update_correct()
                rsLabel.text = "✅"
            }else{
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
                    self.qLabel.text = next.question.decodingHTMLEntities()
                    self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
                    self.rsLabel.text = ""
                    sender.backgroundColor = self.btcolor
                    self.aButton.backgroundColor = self.btcolor
                    self.bButton.backgroundColor = self.btcolor
                    self.cButton.backgroundColor = self.btcolor
                    self.dButton.backgroundColor = self.btcolor
                    var c = next.incorrect_answers
                    c.append(next.correct_answer)
                    self.choices = c
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
                    self.qLabel.text = next.question.decodingHTMLEntities()
                    self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
                    self.rsLabel.text = ""
                    sender.backgroundColor = self.btcolor
                }
            }
        }
    }
    
    
    
    
    func getTrivia() {
        if replay != nil {
            triviaset = replay.set
            turnsleft = triviaset.count
            state = State.init(all: turnsleft)
            qLabel.text = triviaset[0].question.decodingHTMLEntities()
            self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
            
            //mc
            if self.mode == "multiple"{
                var c = self.triviaset[0].incorrect_answers
                c.append(self.triviaset[0].correct_answer)
                self.choices = c
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
                    self.qLabel.text = self.triviaset[0].question.decodingHTMLEntities()
                    self.stateLabel.text = "\(self.state.all - self.turnsleft+1)/\(self.state.all)"
                    //mc
                    if self.mode == "multiple"{
                        var c = self.triviaset[0].incorrect_answers
                        c.append(self.triviaset[0].correct_answer)
                        self.choices = c
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


//====================================DecodeHTML============================================//
// Swift 4
// Check out the history for contributions and acknowledgements.

extension String {
    /// Returns a new string made by replacing all HTML character entity references with the corresponding character.
    ///
    /// - Returns: decoded string
    func decodingHTMLEntities() -> String {
        var result = String()
        var position = startIndex
        
        // Get the range to the next '&'
        while let ampRange = range(of: "&", range: position ..< endIndex) {
            result += self[position ..< ampRange.lowerBound]
            position = ampRange.lowerBound
            
            // Get the range to the next ';'
            if let semiRange = range(of: ";", range: position ..< endIndex ) {
                if let nextAmpRange = range(of: "&", range: index(position, offsetBy: 1) ..< endIndex ),
                    nextAmpRange.upperBound < semiRange.upperBound {
                    // We have an other "&" before the next ";", let's add it and step over.
                    result += "&"
                    position = index(ampRange.lowerBound, offsetBy: 1)
                } else {
                    let entity = String(self[position ..< semiRange.upperBound])
                    if let decoded = decode(entity: entity) {
                        // Add the decoded character.
                        result.append(decoded)
                    } else {
                        // Character wasn't decoded, append the entry.
                        result += entity
                    }
                    position = semiRange.upperBound
                }
            } else {
                // No remaining ';'.
                break
            }
        }
        
        // Add remaining characters.
        result += self[position ..< endIndex]
        return result
    }
}

private extension String {
    
    /// Convert the numeric value to the corresponding Unicode character
    ///    e.g.
    ///    decodeNumeric("64", 10) -> "@"
    ///    decodeNumeric("20ac", 16) -> "€"
    ///
    /// - Parameters:
    ///   - string: the string to decode
    ///   - base: base value of the integer
    /// - Returns: the resulting character
    func decodeNumeric(string: String, base: Int32) -> Character? {
        let code = UInt32(strtoul(string, nil, base))
        if let unicodeScalar = UnicodeScalar(code) {
            return Character(unicodeScalar)
        }
        return nil
    }
    
    /// Decode the HTML character entity to the corresponding
    /// Unicode character, return `nil` for invalid input.
    ///     decode("&#64;")    -> "@"
    ///     decode("&#x20ac;") -> "€"
    ///     decode("&lt;")     -> "<"
    ///     decode("&foo;")    -> nil
    ///
    /// - Parameter entity: The entity reference
    /// - Returns: the resulting character
    func decode(entity: String) -> Character? {
        if let character = String.characterEntities[entity] {
            return character
        } else if entity.hasPrefix("&#x") || entity.hasPrefix("&#X") {
            let number = String(entity[entity.index(entity.startIndex, offsetBy: 3)...].dropLast())
            return decodeNumeric(string: number, base: 16)
        } else if entity.hasPrefix("&#") {
            let number = String(entity[entity.index(entity.startIndex, offsetBy: 2)...].dropLast())
            return decodeNumeric(string: number, base: 10)
        } else {
            return nil
        }
    }
    
    // Mapping from XML/HTML character entity reference to character
    static let characterEntities: [String: Character] = [
        // Taken from http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
        // Complete refrence here https://www.w3.org/TR/xml-entity-names/
        "&quot;": "\u{0022}",
        "&amp;": "\u{0026}",
        "&apos;": "\u{0027}",
        "&lt;": "\u{003C}",
        "&gt;": "\u{003E}",
        "&nbsp;": "\u{00A0}",
        "&iexcl;": "\u{00A1}",
        "&cent;": "\u{00A2}",
        "&pound;": "\u{00A3}",
        "&curren;": "\u{00A4}",
        "&yen;": "\u{00A5}",
        "&brvbar;": "\u{00A6}",
        "&sect;": "\u{00A7}",
        "&uml;": "\u{00A8}",
        "&copy;": "\u{00A9}",
        "&ordf;": "\u{00AA}",
        "&laquo;": "\u{00AB}",
        "&not;": "\u{00AC}",
        "&shy;": "\u{00AD}",
        "&reg;": "\u{00AE}",
        "&macr;": "\u{00AF}",
        "&deg;": "\u{00B0}",
        "&plusmn;": "\u{00B1}",
        "&sup2;": "\u{00B2}",
        "&sup3;": "\u{00B3}",
        "&acute;": "\u{00B4}",
        "&micro;": "\u{00B5}",
        "&para;": "\u{00B6}",
        "&middot;": "\u{00B7}",
        "&cedil;": "\u{00B8}",
        "&sup1;": "\u{00B9}",
        "&ordm;": "\u{00BA}",
        "&raquo;": "\u{00BB}",
        "&frac14;": "\u{00BC}",
        "&frac12;": "\u{00BD}",
        "&frac34;": "\u{00BE}",
        "&iquest;": "\u{00BF}",
        "&Agrave;": "\u{00C0}",
        "&Aacute;": "\u{00C1}",
        "&Acirc;": "\u{00C2}",
        "&Atilde;": "\u{00C3}",
        "&Auml;": "\u{00C4}",
        "&Aring;": "\u{00C5}",
        "&AElig;": "\u{00C6}",
        "&Ccedil;": "\u{00C7}",
        "&Egrave;": "\u{00C8}",
        "&Eacute;": "\u{00C9}",
        "&Ecirc;": "\u{00CA}",
        "&Euml;": "\u{00CB}",
        "&Igrave;": "\u{00CC}",
        "&Iacute;": "\u{00CD}",
        "&Icirc;": "\u{00CE}",
        "&Iuml;": "\u{00CF}",
        "&ETH;": "\u{00D0}",
        "&Ntilde;": "\u{00D1}",
        "&Ograve;": "\u{00D2}",
        "&Oacute;": "\u{00D3}",
        "&Ocirc;": "\u{00D4}",
        "&Otilde;": "\u{00D5}",
        "&Ouml;": "\u{00D6}",
        "&times;": "\u{00D7}",
        "&Oslash;": "\u{00D8}",
        "&Ugrave;": "\u{00D9}",
        "&Uacute;": "\u{00DA}",
        "&Ucirc;": "\u{00DB}",
        "&Uuml;": "\u{00DC}",
        "&Yacute;": "\u{00DD}",
        "&THORN;": "\u{00DE}",
        "&szlig;": "\u{00DF}",
        "&agrave;": "\u{00E0}",
        "&aacute;": "\u{00E1}",
        "&acirc;": "\u{00E2}",
        "&atilde;": "\u{00E3}",
        "&auml;": "\u{00E4}",
        "&aring;": "\u{00E5}",
        "&aelig;": "\u{00E6}",
        "&ccedil;": "\u{00E7}",
        "&egrave;": "\u{00E8}",
        "&eacute;": "\u{00E9}",
        "&ecirc;": "\u{00EA}",
        "&euml;": "\u{00EB}",
        "&igrave;": "\u{00EC}",
        "&iacute;": "\u{00ED}",
        "&icirc;": "\u{00EE}",
        "&iuml;": "\u{00EF}",
        "&eth;": "\u{00F0}",
        "&ntilde;": "\u{00F1}",
        "&ograve;": "\u{00F2}",
        "&oacute;": "\u{00F3}",
        "&ocirc;": "\u{00F4}",
        "&otilde;": "\u{00F5}",
        "&ouml;": "\u{00F6}",
        "&divide;": "\u{00F7}",
        "&oslash;": "\u{00F8}",
        "&ugrave;": "\u{00F9}",
        "&uacute;": "\u{00FA}",
        "&ucirc;": "\u{00FB}",
        "&uuml;": "\u{00FC}",
        "&yacute;": "\u{00FD}",
        "&thorn;": "\u{00FE}",
        "&yuml;": "\u{00FF}",
        "&OElig;": "\u{0152}",
        "&oelig;": "\u{0153}",
        "&Scaron;": "\u{0160}",
        "&scaron;": "\u{0161}",
        "&Yuml;": "\u{0178}",
        "&fnof;": "\u{0192}",
        "&circ;": "\u{02C6}",
        "&tilde;": "\u{02DC}",
        "&Alpha;": "\u{0391}",
        "&Beta;": "\u{0392}",
        "&Gamma;": "\u{0393}",
        "&Delta;": "\u{0394}",
        "&Epsilon;": "\u{0395}",
        "&Zeta;": "\u{0396}",
        "&Eta;": "\u{0397}",
        "&Theta;": "\u{0398}",
        "&Iota;": "\u{0399}",
        "&Kappa;": "\u{039A}",
        "&Lambda;": "\u{039B}",
        "&Mu;": "\u{039C}",
        "&Nu;": "\u{039D}",
        "&Xi;": "\u{039E}",
        "&Omicron;": "\u{039F}",
        "&Pi;": "\u{03A0}",
        "&Rho;": "\u{03A1}",
        "&Sigma;": "\u{03A3}",
        "&Tau;": "\u{03A4}",
        "&Upsilon;": "\u{03A5}",
        "&Phi;": "\u{03A6}",
        "&Chi;": "\u{03A7}",
        "&Psi;": "\u{03A8}",
        "&Omega;": "\u{03A9}",
        "&alpha;": "\u{03B1}",
        "&beta;": "\u{03B2}",
        "&gamma;": "\u{03B3}",
        "&delta;": "\u{03B4}",
        "&epsilon;": "\u{03B5}",
        "&zeta;": "\u{03B6}",
        "&eta;": "\u{03B7}",
        "&theta;": "\u{03B8}",
        "&iota;": "\u{03B9}",
        "&kappa;": "\u{03BA}",
        "&lambda;": "\u{03BB}",
        "&mu;": "\u{03BC}",
        "&nu;": "\u{03BD}",
        "&xi;": "\u{03BE}",
        "&omicron;": "\u{03BF}",
        "&pi;": "\u{03C0}",
        "&rho;": "\u{03C1}",
        "&sigmaf;": "\u{03C2}",
        "&sigma;": "\u{03C3}",
        "&tau;": "\u{03C4}",
        "&upsilon;": "\u{03C5}",
        "&phi;": "\u{03C6}",
        "&chi;": "\u{03C7}",
        "&psi;": "\u{03C8}",
        "&omega;": "\u{03C9}",
        "&thetasym;": "\u{03D1}",
        "&upsih;": "\u{03D2}",
        "&piv;": "\u{03D6}",
        "&ensp;": "\u{2002}",
        "&emsp;": "\u{2003}",
        "&thinsp;": "\u{2009}",
        "&zwnj;": "\u{200C}",
        "&zwj;": "\u{200D}",
        "&lrm;": "\u{200E}",
        "&rlm;": "\u{200F}",
        "&ndash;": "\u{2013}",
        "&mdash;": "\u{2014}",
        "&lsquo;": "\u{2018}",
        "&rsquo;": "\u{2019}",
        "&sbquo;": "\u{201A}",
        "&ldquo;": "\u{201C}",
        "&rdquo;": "\u{201D}",
        "&bdquo;": "\u{201E}",
        "&dagger;": "\u{2020}",
        "&Dagger;": "\u{2021}",
        "&bull;": "\u{2022}",
        "&hellip;": "\u{2026}",
        "&permil;": "\u{2030}",
        "&prime;": "\u{2032}",
        "&Prime;": "\u{2033}",
        "&lsaquo;": "\u{2039}",
        "&rsaquo;": "\u{203A}",
        "&oline;": "\u{203E}",
        "&frasl;": "\u{2044}",
        "&euro;": "\u{20AC}",
        "&image;": "\u{2111}",
        "&weierp;": "\u{2118}",
        "&real;": "\u{211C}",
        "&trade;": "\u{2122}",
        "&alefsym;": "\u{2135}",
        "&larr;": "\u{2190}",
        "&uarr;": "\u{2191}",
        "&rarr;": "\u{2192}",
        "&darr;": "\u{2193}",
        "&harr;": "\u{2194}",
        "&crarr;": "\u{21B5}",
        "&lArr;": "\u{21D0}",
        "&uArr;": "\u{21D1}",
        "&rArr;": "\u{21D2}",
        "&dArr;": "\u{21D3}",
        "&hArr;": "\u{21D4}",
        "&forall;": "\u{2200}",
        "&part;": "\u{2202}",
        "&exist;": "\u{2203}",
        "&empty;": "\u{2205}",
        "&nabla;": "\u{2207}",
        "&isin;": "\u{2208}",
        "&notin;": "\u{2209}",
        "&ni;": "\u{220B}",
        "&prod;": "\u{220F}",
        "&sum;": "\u{2211}",
        "&minus;": "\u{2212}",
        "&lowast;": "\u{2217}",
        "&radic;": "\u{221A}",
        "&prop;": "\u{221D}",
        "&infin;": "\u{221E}",
        "&ang;": "\u{2220}",
        "&and;": "\u{2227}",
        "&or;": "\u{2228}",
        "&cap;": "\u{2229}",
        "&cup;": "\u{222A}",
        "&int;": "\u{222B}",
        "&there4;": "\u{2234}",
        "&sim;": "\u{223C}",
        "&cong;": "\u{2245}",
        "&asymp;": "\u{2248}",
        "&ne;": "\u{2260}",
        "&equiv;": "\u{2261}",
        "&le;": "\u{2264}",
        "&ge;": "\u{2265}",
        "&sub;": "\u{2282}",
        "&sup;": "\u{2283}",
        "&nsub;": "\u{2284}",
        "&sube;": "\u{2286}",
        "&supe;": "\u{2287}",
        "&oplus;": "\u{2295}",
        "&otimes;": "\u{2297}",
        "&perp;": "\u{22A5}",
        "&sdot;": "\u{22C5}",
        "&lceil;": "\u{2308}",
        "&rceil;": "\u{2309}",
        "&lfloor;": "\u{230A}",
        "&rfloor;": "\u{230B}",
        "&lang;": "\u{2329}",
        "&rang;": "\u{232A}",
        "&loz;": "\u{25CA}",
        "&spades;": "\u{2660}",
        "&clubs;": "\u{2663}",
        "&hearts;": "\u{2665}",
        "&diams;": "\u{2666}",
        
        // Special cases from Windows-1252. https://en.wikipedia.org/wiki/Windows-1252
        "&#128;": "\u{20AC}",
        "&#130;": "\u{201A}",
        "&#131;": "\u{0192}",
        "&#132;": "\u{201E}",
        "&#133;": "\u{2026}",
        "&#134;": "\u{2020}",
        "&#135;": "\u{2021}",
        "&#136;": "\u{02C6}",
        "&#138;": "\u{0160}",
        "&#139;": "\u{2039}",
        "&#140;": "\u{0152}",
        "&#142;": "\u{017D}",
        "&#145;": "\u{2018}",
        "&#146;": "\u{2019}",
        "&#147;": "\u{201C}",
        "&#148;": "\u{201D}",
        "&#149;": "\u{2022}",
        "&#150;": "\u{2013}",
        "&#151;": "\u{2014}",
        "&#152;": "\u{02DC}",
        "&#153;": "\u{2122}",
        "&#154;": "\u{0161}",
        "&#155;": "\u{203A}",
        "&#156;": "\u{0153}",
        "&#158;": "\u{017E}",
        "&#159;": "\u{0178}"
    ]
}
