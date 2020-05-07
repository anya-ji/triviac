//
//  PlayViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    let bgcolor = UIColor(red: 0.54, green: 0.80, blue: 0.53, alpha: 1.00)
    let btcolor = UIColor(red: 0.89, green: 0.99, blue: 0.88, alpha: 1.00)
    let slcolor = UIColor(red: 1.00, green: 0.75, blue: 0.27, alpha: 1.00)
    
    var qLabel: UILabel!
    var tButton: UIButton!
    var fButton: UIButton!
    var rsLabel: UILabel!
    
    let gap: CGFloat = 30
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgcolor
        
        qLabel = UILabel()
        qLabel.text = "Question"
        qLabel.textColor = .white
        qLabel.font = UIFont.init(name: "Chalkduster", size: 30)
        qLabel.textAlignment = .center
        view.addSubview(qLabel)
        
        tButton = UIButton()
        tButton.setTitle("T", for: .normal)
        tButton.backgroundColor = btcolor
        tButton.setTitleColor(.white, for: .normal)
        tButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
        tButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 100)
        tButton.titleLabel?.textAlignment = .center
        tButton.layer.cornerRadius = 15
        tButton.layer.borderWidth = 1
        tButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(tButton)
        
        fButton = UIButton()
        fButton.setTitle("F", for: .normal)
        fButton.backgroundColor = btcolor
        fButton.setTitleColor(.white, for: .normal)
        fButton.addTarget(self, action: #selector(sl), for: .touchUpInside)
        fButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 100)
        fButton.titleLabel?.textAlignment = .center
        fButton.layer.cornerRadius = 15
        fButton.layer.borderWidth = 1
        fButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(fButton)
        
        setup()
        
    }
    
    func setup(){
        qLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-gap)
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.bottom.equalTo(view.snp.centerY)
        }
        
        tButton.snp.makeConstraints{make in
            make.top.equalTo(qLabel.snp.bottom).offset(gap*3)
            make.height.equalTo(100)
            make.width.equalTo(150)
            make.leading.equalToSuperview().offset(gap)
        }
        tButton.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        fButton.snp.makeConstraints{make in
            make.top.equalTo(qLabel.snp.bottom).offset(gap*3)
            make.height.equalTo(100)
            make.width.equalTo(150)
            make.trailing.equalToSuperview().offset(-gap)
        }
        fButton.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
    }
    
    @objc func sl(){
        if tButton.isSelected {
            tButton.backgroundColor = slcolor
        } else {
        fButton.backgroundColor = slcolor
        }
    }
    
    

    

}
