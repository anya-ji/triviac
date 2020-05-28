//
//  CreateViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/4/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import SnapKit

protocol CatChangeTextDelegate: class {
    func catTextChanged(to newCat: String)
}

class CreateViewController: UIViewController {
    var numLabel: UILabel!
    var numText: UITextField!
    var add: UIButton!
    var sub: UIButton!
    var catLabel: UILabel!
    var cat: UIButton!
    var difLabel: UILabel!
    var dif: UIButton!
    var typLabel: UILabel!
    var typ: UIButton!
    var gen: UIButton!
    
    let ls = CGFloat(30)

    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let gencolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    let btcolor = UIColor(red: 0.77, green: 0.76, blue: 0.78, alpha: 1.00)
    let textcolor = UIColor.white
    
    
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
        
        view.backgroundColor = bgcolor
        self.title = "Generate a trivia!"
        navigationController?.navigationBar.barTintColor = gencolor
        navigationController?.navigationBar.titleTextAttributes = [
           // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        parseJSON()
        
        //number of questions
        numLabel = UILabel()
        numLabel.text = "# Questions"
        numLabel.textColor = textcolor
        numLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        numLabel.textAlignment = .center
        numLabel.adjustsFontSizeToFitWidth = true
        
        numText = UITextField()
        numText.backgroundColor = .white
        numText.text = "10"
        numText.borderStyle = UITextField.BorderStyle.roundedRect
        numText.textAlignment = .center
        numText.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        numText.textAlignment = .center
        numText.adjustsFontSizeToFitWidth = true
        
        add = UIButton()
        add.setTitle("+", for: .normal)
        add.titleLabel?.text = "+"
        add.backgroundColor = btcolor
        add.setTitleColor(.white, for: .normal)
        add.addTarget(self, action: #selector(addf), for: .touchUpInside)
        add.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls-10)
        add.layer.cornerRadius = 5
        add.layer.borderWidth = 1
        add.layer.borderColor = UIColor.white.cgColor
        add.titleLabel?.adjustsFontSizeToFitWidth = true
        
        sub = UIButton()
        sub.setTitle("-", for: .normal)
        sub.backgroundColor = btcolor
        sub.setTitleColor(.white, for: .normal)
        sub.addTarget(self, action: #selector(subf), for: .touchUpInside)
        sub.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls-10)
        sub.titleLabel?.textAlignment = .center
        sub.layer.cornerRadius = 5
        sub.layer.borderWidth = 1
        sub.layer.borderColor = UIColor.white.cgColor
        sub.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //category
        catLabel = UILabel()
        catLabel.text = "Category"
        catLabel.textColor = textcolor
        catLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        catLabel.textAlignment = .center
        catLabel.adjustsFontSizeToFitWidth = true
        
        cat = UIButton()
        cat.setTitle("Any Category", for: .normal)
        cat.backgroundColor = btcolor
        cat.setTitleColor(.white, for: .normal)
        cat.addTarget(self, action: #selector(catf), for: .touchUpInside)
        cat.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        cat.titleLabel?.textAlignment = .center
        cat.titleLabel?.adjustsFontSizeToFitWidth = true
        //cat.sizeToFit()
        cat.layer.cornerRadius = 15
        cat.layer.borderWidth = 1
        cat.layer.borderColor = UIColor.white.cgColor
        
        //difficulty
        difLabel = UILabel()
        difLabel.text = "Difficulty"
        difLabel.textColor = textcolor
        difLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        difLabel.textAlignment = .center
        difLabel.adjustsFontSizeToFitWidth = true
        
        dif = UIButton()
        dif.setTitle("Easy", for: .normal)
        dif.backgroundColor = btcolor
        dif.setTitleColor(.white, for: .normal)
        dif.addTarget(self, action: #selector(diff), for: .touchUpInside)
        dif.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        dif.titleLabel?.textAlignment = .center
        dif.layer.cornerRadius = 15
        dif.layer.borderWidth = 1
        dif.layer.borderColor = UIColor.white.cgColor
        dif.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        //type
        typLabel = UILabel()
        typLabel.text = "Type"
        typLabel.textColor = textcolor
        typLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        typLabel.textAlignment = .center
        typLabel.adjustsFontSizeToFitWidth = true
        
        typ = UIButton()
        typ.setTitle("Multiple Choice", for: .normal)
        typ.backgroundColor = btcolor
        typ.setTitleColor(.white, for: .normal)
        typ.addTarget(self, action: #selector(typf), for: .touchUpInside)
        typ.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls-5)
        typ.titleLabel?.textAlignment = .center
        typ.layer.cornerRadius = 15
        typ.layer.borderWidth = 1
        typ.layer.borderColor = UIColor.white.cgColor
        typ.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //gen
        gen = UIButton()
        gen.setTitle("Generate!", for: .normal)
        gen.backgroundColor = gencolor
        gen.setTitleColor(.white, for: .normal)
        gen.addTarget(self, action: #selector(genf), for: .touchUpInside)
        gen.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        gen.titleLabel?.textAlignment = .center
        gen.layer.cornerRadius = 20
        gen.layer.borderWidth = 3
        gen.layer.borderColor = UIColor.white.cgColor
        gen.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //constraints
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
        view.addSubview(gen)
        
        setup()
        
    }
    
    func setup(){
            let ht = CGFloat(50)
            let lwd = CGFloat(300)
            let bwd = CGFloat(130)
        let gap = view.frame.height / 70
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
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(numText.snp.bottom).offset(gap*2)
            make.height.equalTo(ht)
            make.width.equalTo(lwd)
        }
        //cat
        cat.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(catLabel.snp.bottom).offset(gap)
            make.height.equalTo(ht)
            make.width.equalTo(bwd*2)
        }
        cat.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        //difLabel
        difLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(cat.snp.bottom).offset(gap*2)
            make.height.equalTo(ht)
            make.width.equalTo(lwd)
        }
        //dif
        dif.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(difLabel.snp.bottom).offset(gap)
            make.height.equalTo(ht)
            make.width.equalTo(bwd)
        }
        dif.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        //typLabel
        typLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(dif.snp.bottom).offset(gap*2)
            make.height.equalTo(ht)
            make.width.equalTo(lwd)
        }
        //typ
        typ.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(typLabel.snp.bottom).offset(gap)
            make.height.equalTo(ht)
            make.width.equalTo(bwd*2)
        }
        typ.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        //gen
        gen.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
           make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-gap*2)
            //make.top.equalTo(typ.snp.bottom).offset(gap*3)
            //make.height.equalTo(60)
            make.width.equalTo(200)
        }
        gen.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
    }
    
    @objc func addf(){
        let add1 = (Int(numText.text ?? "10") ?? 10) + 1
        if add1 > 50 || add1 <= 0 {
            numText.text = "10"
        } else{
            numText.text = "\(add1)"
        }
    }
    
    @objc func subf(){
        let sub1 = (Int(numText.text ?? "10") ?? 10) - 1
        if sub1 > 50 || sub1 <= 0 {
            numText.text = "10"
        } else{
            numText.text = "\(sub1)"
        }
    }
    
    @objc func catf(){        
        let catVC = CatViewController(placeholder: "")
        catVC!.delegate = self
        present(catVC!, animated: true, completion: nil)
    }
    
    @objc func diff(){
        if dif.titleLabel?.text == "Easy" {
            dif.setTitle("Medium", for: .normal)
        } else if dif.titleLabel?.text == "Medium"{
            dif.setTitle("Hard", for: .normal)
        } else{
            dif.setTitle("Easy", for: .normal)
        }
    }
    
    @objc func typf(){
        if typ.titleLabel?.text == "Multiple Choice" {
            typ.setTitle("True/False", for: .normal)
        } else{
            typ.setTitle("Multiple Choice", for: .normal)
        }
    }
    @objc func genf(){
        let chosendif = (dif.titleLabel?.text)?.lowercased()
        let chosentyp = typ.titleLabel?.text == "Multiple Choice" ? "multiple" : "boolean"
        let tpcat = CreateViewController.catdic[(cat.titleLabel?.text)!]
        let chosencat = tpcat == "any" ?  "" : "&category=\(tpcat!)"
        CreateViewController.endpoint = "\(ed)\(numText.text ?? "10")\(chosencat)&difficulty=\(chosendif!)&type=\(chosentyp)"
        //print(CreateViewController.endpoint)
        
        let playViewController = PlayViewController(mode: chosentyp, replay: nil)
        navigationController?.pushViewController(playViewController, animated: true)
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
                    
                    //                    if let validName = cate.num{
                    //                         print("Name = \(validName)")
                    //                    }
                    //
                    //                    if let validTitle = cate.cat{
                    //                        print("Title = \(validTitle)")
                    //                    }
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
