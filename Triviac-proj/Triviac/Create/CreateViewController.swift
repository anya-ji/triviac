//
//  CreateViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/4/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import AMTabView

protocol CatChangeTextDelegate: class {
    func catTextChanged(to newCat: String)
}

class CreateViewController: UIViewController {
    
//    var tabImage: UIImage? {
//      return UIImage(named: "home")
//    }
    
    var numLabel: UILabel!
    var numText: UITextField!
    var add: UIButton!
    var sub: UIButton!
    var catLabel: UILabel!
    var cat: UIButton!
    var difLabel: UILabel!
    //var dif: UIButton!
    var dif: UISegmentedControl!
    var typLabel: UILabel!
    // var typ: UIButton!
    var typ: UISegmentedControl!
    var modeLabel: UILabel!
    var mode: UISegmentedControl!
    var gen: UIButton!
    var invite: UIButton!
    var join: UIButton!
    
    var notfoundView: UIView!
    var ok: UIButton!
    var prompt: UILabel!
    
    let ls = CGFloat(25)
    
    
    public static var endpoint = "https://opentdb.com/api.php?amount="
    let ed = "https://opentdb.com/api.php?amount="
    
    public static var catdic:[String:String] = [:]
    public static var catarr:[String] = []
    
    //ensure top and bottom bars are always present
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .bgcolor
        self.navigationItem.title = "Generate a Trivia!"
        navigationController?.navigationBar.barTintColor = .accentbuttoncolor
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        parseJSON()
        
        //number of questions
        numLabel = UILabel()
        numLabel.text = "# Questions"
        numLabel.textColor = .textcolor
        numLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        numLabel.textAlignment = .center
        numLabel.adjustsFontSizeToFitWidth = true
        
        numText = UITextField()
        numText.backgroundColor = .white
        numText.text = "10"
        numText.textColor = .black
        numText.borderStyle = UITextField.BorderStyle.roundedRect
        numText.textAlignment = .center
        numText.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        numText.adjustsFontSizeToFitWidth = true
        numText.keyboardType = .numberPad
        
        
        add = UIButton()
        add.setTitle("+", for: .normal)
        add.titleLabel?.text = "+"
        add.backgroundColor = .btcolor
        add.setTitleColor(.white, for: .normal)
        add.addTarget(self, action: #selector(addf), for: .touchUpInside)
        add.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls-10)
        add.layer.cornerRadius = 5
        add.layer.borderWidth = 1
        add.layer.borderColor = UIColor.bordercolor.cgColor
        add.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: add, shadow: .shadowcolor)
        
        sub = UIButton()
        sub.setTitle("-", for: .normal)
        sub.backgroundColor = .btcolor
        sub.setTitleColor(.white, for: .normal)
        sub.addTarget(self, action: #selector(subf), for: .touchUpInside)
        sub.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls-10)
        sub.titleLabel?.textAlignment = .center
        sub.layer.cornerRadius = 5
        sub.layer.borderWidth = 1
        sub.layer.borderColor = UIColor.bordercolor.cgColor
        sub.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: sub, shadow: .shadowcolor)
        
        //category
        catLabel = UILabel()
        catLabel.text = "Category"
        catLabel.textColor = .textcolor
        catLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        catLabel.textAlignment = .center
        catLabel.adjustsFontSizeToFitWidth = true
        
        cat = UIButton()
        cat.setTitle("Any Category", for: .normal)
        cat.backgroundColor = .btcolor
        cat.setTitleColor(.white, for: .normal)
        cat.addTarget(self, action: #selector(catf), for: .touchUpInside)
        cat.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls-10)
        cat.titleLabel?.textAlignment = .center
        cat.titleLabel?.numberOfLines = 0
        cat.titleLabel?.minimumScaleFactor = 0.6
        //cat.titleLabel?.lineBreakMode = .byWordWrapping
        cat.titleLabel?.adjustsFontSizeToFitWidth = true
        cat.sizeToFit()
        applyShadow(button: cat, shadow: .shadowcolor)
        
        //cat.sizeToFit()
        cat.layer.cornerRadius = 15
        cat.layer.borderWidth = 1
        cat.layer.borderColor = UIColor.bordercolor.cgColor
        
        //difficulty
        difLabel = UILabel()
        difLabel.text = "Difficulty"
        difLabel.textColor = .textcolor
        difLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        difLabel.textAlignment = .center
        difLabel.adjustsFontSizeToFitWidth = true
        
        
        dif = UISegmentedControl(items: ["Easy", "Medium", "Hard"])
        dif.tintColor = .white
        dif.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.bgcolor, NSAttributedString.Key.font: UIFont.init(name: "ChalkboardSE-Regular", size: ls-10) as Any], for: .selected)
        dif.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: "ChalkboardSE-Regular", size: ls-10) as Any], for: .normal)
        dif.selectedSegmentIndex = 0
        
        
        //type
        typLabel = UILabel()
        typLabel.text = "Type"
        typLabel.textColor = .textcolor
        typLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        typLabel.textAlignment = .center
        typLabel.adjustsFontSizeToFitWidth = true
        
        
        typ = UISegmentedControl(items: ["Multiple Choice", "True/False"])
        typ.tintColor = .white
        typ.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.bgcolor, NSAttributedString.Key.font: UIFont.init(name: "ChalkboardSE-Regular", size: ls-10) as Any], for: .selected)
        typ.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: "ChalkboardSE-Regular", size: ls-10) as Any], for: .normal)
        typ.selectedSegmentIndex = 0
        
        
        //mode
        modeLabel = UILabel()
        modeLabel.text = "Mode"
        modeLabel.textColor = .textcolor
        modeLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        modeLabel.textAlignment = .center
        modeLabel.adjustsFontSizeToFitWidth = true
        
        mode = UISegmentedControl(items: [UIImage(named: "single")?.resized(to: CGSize(width: 25, height: 25)), UIImage(named: "multi")?.resized(to: CGSize(width: 25, height: 25))])
        mode.tintColor = .white
        mode.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.bgcolor, NSAttributedString.Key.font: UIFont.init(name: "ChalkboardSE-Regular", size: ls-10) as Any], for: .selected)
        mode.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: "ChalkboardSE-Regular", size: ls-10) as Any], for: .normal)
        mode.selectedSegmentIndex = 0
        mode.addTarget(self, action: #selector(changeMode), for: .valueChanged)
        
        //gen
        
        gen = UIButton()
        gen.setTitle("Generate!", for: .normal)
        gen.backgroundColor = .accentbuttoncolor
        gen.setTitleColor(.white, for: .normal)
        gen.addTarget(self, action: #selector(genf), for: .touchUpInside)
        gen.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        gen.titleLabel?.textAlignment = .center
        gen.layer.cornerRadius = 20
        gen.layer.borderWidth = 3
        gen.layer.borderColor = UIColor.white.cgColor
        gen.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: gen, shadow: .shadowcolor)
        view.addSubview(gen)
        
        
        invite = UIButton()
        invite.setTitle("Invite", for: .normal)
        invite.backgroundColor = .accentbuttoncolor
        invite.setTitleColor(.white, for: .normal)
        invite.addTarget(self, action: #selector(invitef), for: .touchUpInside)
        invite.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        invite.titleLabel?.textAlignment = .center
        invite.layer.cornerRadius = 20
        invite.layer.borderWidth = 3
        invite.layer.borderColor = UIColor.white.cgColor
        invite.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: invite, shadow: .shadowcolor)
        view.addSubview(invite)
        invite.isHidden = true
        invite.isEnabled = false
        
        join = UIButton()
        join.setTitle("Join", for: .normal)
        join.backgroundColor = .btcolor
        join.setTitleColor(.white, for: .normal)
        join.addTarget(self, action: #selector(joinf), for: .touchUpInside)
        join.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        join.titleLabel?.textAlignment = .center
        join.layer.cornerRadius = 20
        join.layer.borderWidth = 3
        join.layer.borderColor = UIColor.white.cgColor
        join.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: join, shadow: .shadowcolor)
        view.addSubview(join)
        join.isHidden = true
        join.isEnabled = false
        
        
        //not found
        notfoundView = UIView()
        notfoundView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        notfoundView.layer.cornerRadius = 10
        notfoundView.isHidden = true
        
        ok = UIButton()
        ok.setTitle("OK", for: .normal)
        ok.backgroundColor = .accentbuttoncolor
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
        
        prompt = UILabel()
        prompt.text = "Oops, the trivia doesn't exist.🤯 \nPlease try another combination."
        prompt.textColor = .lightGray
        prompt.font = UIFont.init(name: "Chalkduster", size: 20)
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        
        
        view.addSubview(numLabel)
        view.addSubview(numText)
        view.addSubview(add)
        view.addSubview(sub)
        view.addSubview(catLabel)
        view.addSubview(cat)
        view.addSubview(difLabel)
        view.addSubview(dif)
        view.addSubview(typLabel)
        view.addSubview(typ)
        view.addSubview(modeLabel)
        view.addSubview(mode)
        view.addSubview(notfoundView)
        notfoundView.addSubview(ok)
        notfoundView.addSubview(prompt)
        
        setup()
        
    }
    
    @objc func quit(){
        buttonAnimate(button: ok, shadow: UIColor.darkGray)
        notfoundView.isHidden = true
    }
    
    @objc func changeMode(){
        gen.isEnabled.toggle()
        gen.isHidden.toggle()
        invite.isEnabled.toggle()
        invite.isHidden.toggle()
        join.isEnabled.toggle()
        join.isHidden.toggle()
    }
    
    func setup(){
        let ht = CGFloat(50)
        let lwd = CGFloat(300)
        let bwd = CGFloat(130)
        let gap = view.frame.height / 83
        //numLabel
        numLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(gap)
            make.height.equalTo(ht)
            make.width.equalTo(lwd)
        }
        //numText
        numText.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(numLabel.snp.bottom).offset(gap)
            make.height.equalTo(ht)
            make.width.equalTo(bwd)
        }
        //add
        add.snp.makeConstraints{ make in
            make.centerY.equalTo(numText.snp.centerY)
            make.height.width.equalTo(ht/2)
            make.trailing.equalTo(numText.snp.leading).offset(-gap)
        }
        add.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        //sub
        sub.snp.makeConstraints{ make in
            make.centerY.equalTo(numText.snp.centerY)
            make.height.width.equalTo(ht/2)
            make.leading.equalTo(numText.snp.trailing).offset(gap)
        }
        sub.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        
        //catLabel
        catLabel.snp.makeConstraints{ make in
            make.top.equalTo(numText.snp.bottom).offset(gap*3)
            make.height.equalTo(ht)
            make.leading.equalToSuperview()
            //make.trailing.equalTo(view.snp.centerX)
            make.width.equalTo(view.frame.width/2.3)
        }
        //cat
        cat.snp.makeConstraints{ make in
            make.leading.equalTo(difLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-gap)
            make.height.equalTo(ht)
            make.top.equalTo(catLabel.snp.top)
        }
        cat.titleLabel?.snp.makeConstraints{ make in
            //make.centerY.equalToSuperview().offset(-3)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        
        //difLabel
        difLabel.snp.makeConstraints{ make in
            make.top.equalTo(cat.snp.bottom).offset(gap*3)
            make.height.equalTo(ht)
            make.leading.equalToSuperview()
            //make.trailing.equalTo(view.snp.centerX)
            make.width.equalTo(view.frame.width/2.3)
        }
        
        dif.snp.makeConstraints{ make in
            //make.leading.equalTo(view.snp.centerX).offset(gap)
            make.leading.equalTo(difLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-gap)
            //make.width.equalTo(view.frame.width/2 - 2*gap)
            make.height.equalTo(ht)
            make.top.equalTo(difLabel.snp.top)
        }
        
        
        //typLabel
        typLabel.snp.makeConstraints{ make in
            make.top.equalTo(dif.snp.bottom).offset(gap*3)
            make.height.equalTo(ht)
            make.leading.equalToSuperview()
            //make.trailing.equalTo(view.snp.centerX)
            make.width.equalTo(view.frame.width/3)
        }
        
        typ.snp.makeConstraints{ make in
            //make.leading.equalTo(view.snp.centerX).offset(-gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.height.equalTo(ht)
            //make.width.equalTo(240)
            make.leading.equalTo(typLabel.snp.trailing)
            make.top.equalTo(typLabel.snp.top)
        }
        
        //modeLabel
        modeLabel.snp.makeConstraints{ make in
            make.top.equalTo(typ.snp.bottom).offset(gap*3)
            make.height.equalTo(ht)
            make.leading.equalToSuperview()
            //make.trailing.equalTo(view.snp.centerX)
            make.width.equalTo(view.frame.width/3)
        }
        
        mode.snp.makeConstraints{ make in
            //make.leading.equalTo(view.snp.centerX).offset(-gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.height.equalTo(ht)
            //make.width.equalTo(240)
            make.leading.equalTo(modeLabel.snp.trailing)
            make.top.equalTo(modeLabel.snp.top)
        }
        
        //gen
        gen.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-gap*5)
            //make.top.equalTo(typ.snp.bottom).offset(gap*3)
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        gen.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        
        
        //invite
        invite.snp.makeConstraints{ make in
            make.trailing.equalTo(view.snp.centerX).offset(-gap)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-gap*5)
            make.height.equalTo(60)
            make.width.equalTo(120)
        }
        invite.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        //join
        join.snp.makeConstraints{ make in
            make.leading.equalTo(view.snp.centerX).offset(gap)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-gap*5)
            make.height.equalTo(60)
            make.width.equalTo(120)
        }
        join.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        //notfound
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
        
        
    }
    
    @objc func addf(){
        let add1 = (Int(numText.text ?? "10") ?? 10) + 1
        if add1 > 50 || add1 <= 0 {
            numText.text = "10"
        } else{
            numText.text = "\(add1)"
        }
        buttonAnimate(button: add, shadow: .shadowcolor)
    }
    
    @objc func subf(){
        let sub1 = (Int(numText.text ?? "10") ?? 10) - 1
        if sub1 > 50 || sub1 <= 0 {
            numText.text = "10"
        } else{
            numText.text = "\(sub1)"
        }
        buttonAnimate(button: sub, shadow: .shadowcolor)
    }
    
    @objc func catf(){        
        let catVC = CatViewController(placeholder: "")
        catVC!.delegate = self
        buttonAnimate(button: cat, shadow: .shadowcolor)
        present(catVC!, animated: true, completion: nil)
    }
    
    func makeEndpoint(){
        var chosennum = "10"
        if let num = Int(String(numText.text ?? "10")) {
            if (num >= 1 && num <= 50) {
                chosennum = String(num)
            }
        }
        let chosendif = dif.titleForSegment(at: dif.selectedSegmentIndex)?.lowercased()
        let chosentyp = typ.titleForSegment(at: typ.selectedSegmentIndex) == "Multiple Choice" ? "multiple" : "boolean"
        let tpcat = CreateViewController.catdic[(cat.titleLabel?.text)!]
        let chosencat = tpcat == "any" ?  "" : "&category=\(tpcat!)"
        CreateViewController.endpoint = "\(ed)\(chosennum)\(chosencat)&difficulty=\(chosendif!)&type=\(chosentyp)"
        //print(CreateViewController.endpoint)
    }
    
    @objc func genf(){
        buttonAnimate(button: gen, shadow: .shadowcolor)
        
        makeEndpoint()
        
        let chosentyp = typ.titleForSegment(at: typ.selectedSegmentIndex) == "Multiple Choice" ? "multiple" : "boolean"
        
        NetworkManager.getTrivia(){
            triviaset in
            if triviaset.isEmpty {
                self.notfoundView.isHidden = false
                //TODO: disable background buttons
            }
            else{
                let playViewController = PlayViewController(mode: chosentyp, replay: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.pushViewController(playViewController, animated: true)
                }
            }
        }
    }
    
    @objc func invitef(){
        buttonAnimate(button: invite, shadow: .shadowcolor)
        
        makeEndpoint()
        
        NetworkManager.getTrivia(){
            triviaset in
            if triviaset.isEmpty {
                self.notfoundView.isHidden = false
                //TODO: disable background buttons
            }
            else{
                if Auth.auth().currentUser?.uid == nil {
                    self.tabBarController!.selectedIndex = 2
                }
                else{
                    let newGame = Game.init(joiner: "", gameState: 0, triviaset: triviaset)
                    DatabaseManager.createGame(game: newGame)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let waitingVC = WaitingViewController()
                        self.navigationController?.pushViewController(waitingVC, animated: true)
                        
                    }
                }
            }
        }
    }
    

@objc func joinf(){
    buttonAnimate(button: join, shadow: .shadowcolor)
    let joinViewController = JoinViewController()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        if Auth.auth().currentUser?.uid == nil {
            self.tabBarController!.selectedIndex = 2
        }
        else{
            self.navigationController?.pushViewController(joinViewController, animated: true)
        }  
    }
}

func parseJSON(){
    var rs: [String:String] = [:]
    var ra: [String] = []
    
    if let path = Bundle.main.path(forResource: "category", ofType: "json") {
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode(CatResponse.self, from: data)
            
            let catsArray = jsonResult.category
            
            
            for cate in catsArray{
                rs[cate.cat!] = cate.num
                ra.append(cate.cat!)
            }
            
            
        } catch {
            print(error)
        }
    }
    CreateViewController.catdic = rs
    CreateViewController.catarr = ra
}

}

extension CreateViewController: CatChangeTextDelegate{
    func catTextChanged(to newCat: String){
        cat.setTitle(newCat, for: .normal)
    }
}

//hide keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    func applyShadow(button: UIButton, shadow: UIColor){
        button.layer.shadowColor = shadow.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    func buttonAnimate(button: UIButton, shadow: UIColor){
        UIView.animate(withDuration: 0.1,
                       animations: {
                        button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                        button.layer.shadowColor = UIColor.clear.cgColor
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            button.transform = CGAffineTransform.identity
                            button.layer.shadowColor = shadow.cgColor
                        }
        })
    }
}



