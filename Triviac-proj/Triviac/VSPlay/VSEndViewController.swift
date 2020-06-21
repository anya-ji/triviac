//
//  EndViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/8/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class VSEndViewController: UIViewController {
    
    var descriptionLabel: UILabel!
    var rsLabel: UILabel!
    var quitButton: UIButton!
    var oprsLabel: UILabel!
    
    let gap: CGFloat = 10
    
    var score: Int!
    var total: Int!
    
    var result: VSPlayViewController.Result!
    
    var myImageView: UIImageView!
    var opImageView: UIImageView!
    
    init(state: State, result: VSPlayViewController.Result){
        super.init(nibName: nil, bundle: nil)
        self.score = state.correct
        self.total = state.all
        self.result = result
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accentbuttoncolor
        
        rsLabel = UILabel()
        view.addSubview(rsLabel)
        rsLabel.lineBreakMode = .byWordWrapping
        rsLabel.text = "\(score!) / \(total!)"
        rsLabel.numberOfLines = 2
        rsLabel.textColor = .white
        
        switch result {
        case .win:
            rsLabel.font = UIFont.init(name: "Chalkduster", size: 50)
        case .tie:
            rsLabel.font = UIFont.init(name: "Chalkduster", size: 50)
        case .lose:
            rsLabel.font = UIFont.init(name: "Chalkduster", size: 25)
        case .none:
            break
        }
        
        rsLabel.adjustsFontSizeToFitWidth = true
        rsLabel.textAlignment = .center
        
        myImageView = UIImageView()
        myImageView.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        myImageView.backgroundColor = .clear
        myImageView.tintColor = UIColor.init(hex: DatabaseManager.currentPlayer.color)
        view.addSubview(myImageView)
        
        opImageView = UIImageView()
        opImageView.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        opImageView.backgroundColor = .clear
        opImageView.tintColor = UIColor.init(hex: DatabaseManager.opponent.color)
        view.addSubview(opImageView)
        
        
        oprsLabel = UILabel()
        view.addSubview(oprsLabel)
        oprsLabel.lineBreakMode = .byWordWrapping
        oprsLabel.text = "\(DatabaseManager.opponent.score!) / \(total!)"
        oprsLabel.numberOfLines = 2
        oprsLabel.textColor = .white
        
        switch result {
        case .win:
            oprsLabel.font = UIFont.init(name: "Chalkduster", size: 25)
        case .tie:
            oprsLabel.font = UIFont.init(name: "Chalkduster", size: 50)
        case .lose:
            oprsLabel.font = UIFont.init(name: "Chalkduster", size: 50)
        case .none:
            break
            
        }

        oprsLabel.adjustsFontSizeToFitWidth = true
        oprsLabel.textAlignment = .center
        
        descriptionLabel = UILabel()
        switch result{
        case .win:
            descriptionLabel.text = "🎉 Congrats! 🤓 \n You won!"
            descriptionLabel.textColor = .orange
        case .tie:
            descriptionLabel.text = "😬 Phew 📚 \n It's a tie!"
            descriptionLabel.textColor = .tiecolor
        case .lose:
            descriptionLabel.text = "🤯 Oops 😰 \n You lost..."
            descriptionLabel.textColor = .white
        case .none:
            break
        }
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.init(name: "Chalkduster", size: 30)
        descriptionLabel.textAlignment = .center
        descriptionLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(descriptionLabel)
        
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
        
        
        setup()
    }
    
    func setup(){
        switch result{
        case .win:
            myImageView.snp.makeConstraints { (make) in
                make.bottom.equalTo(view.snp.centerY)
                make.height.width.equalTo(120)
                make.centerX.equalToSuperview()
            }
            
            rsLabel.snp.makeConstraints { (make) in
                make.top.equalTo(myImageView.snp.bottom)
                make.centerX.equalToSuperview()
                make.height.equalTo(70)
                make.leading.trailing.equalToSuperview()
            }
            
            
            opImageView.snp.makeConstraints { (make) in
                make.height.width.equalTo(80)
                make.leading.equalTo(view.snp.centerX).offset(gap)
                make.top.equalTo(rsLabel.snp.bottom).offset(gap)
            }
            
            oprsLabel.snp.makeConstraints { (make) in
                make.height.equalTo(25)
                make.trailing.equalTo(opImageView.snp.leading).offset(-10)
                make.centerY.equalTo(opImageView.snp.centerY)
            }
            
            descriptionLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(gap)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
                make.bottom.equalTo(myImageView.snp.top).offset(-gap)
            }
            
            quitButton.snp.makeConstraints{ make in
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(opImageView.snp.bottom).offset(gap*5)
                make.height.equalTo(60)
                make.width.equalTo(150)
            }
            quitButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
        case .tie:
            
            myImageView.snp.makeConstraints { (make) in
                make.height.width.equalTo(80)
                make.trailing.equalTo(view.snp.centerX).offset(-gap)
                make.bottom.equalTo(view.snp.centerY).offset(-gap)
            }
            
            rsLabel.snp.makeConstraints { (make) in
                make.height.equalTo(50)
                make.leading.equalTo(myImageView.snp.trailing).offset(gap*3)
                make.centerY.equalTo(myImageView.snp.centerY)
            }
            
            opImageView.snp.makeConstraints { (make) in
                make.height.width.equalTo(80)
                make.leading.equalTo(view.snp.centerX).offset(gap)
                make.top.equalTo(view.snp.centerY).offset(gap)
            }
            
            oprsLabel.snp.makeConstraints { (make) in
                make.height.equalTo(50)
                make.trailing.equalTo(opImageView.snp.leading).offset(-gap*3)
                make.centerY.equalTo(opImageView.snp.centerY)
            }
            
            descriptionLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(gap)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
                make.bottom.equalTo(myImageView.snp.top).offset(-gap)
            }
            
            quitButton.snp.makeConstraints{ make in
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(opImageView.snp.bottom).offset(gap*5)
                make.height.equalTo(60)
                make.width.equalTo(150)
            }
            quitButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
        case .lose:
            opImageView.snp.makeConstraints { (make) in
                make.bottom.equalTo(view.snp.centerY)
                make.height.width.equalTo(120)
                make.centerX.equalToSuperview()
            }
            
            oprsLabel.snp.makeConstraints { (make) in
                make.top.equalTo(opImageView.snp.bottom)
                make.centerX.equalToSuperview()
                make.height.equalTo(70)
                make.leading.trailing.equalToSuperview()
            }
            
            
            myImageView.snp.makeConstraints { (make) in
                make.height.width.equalTo(80)
                make.leading.equalTo(view.snp.centerX).offset(gap)
                make.top.equalTo(oprsLabel.snp.bottom).offset(gap)
            }
            
            rsLabel.snp.makeConstraints { (make) in
                make.height.equalTo(25)
                make.trailing.equalTo(myImageView.snp.leading).offset(-10)
                make.centerY.equalTo(myImageView.snp.centerY)
            }
            
            descriptionLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(gap)
                make.leading.equalToSuperview().offset(gap)
                make.trailing.equalToSuperview().offset(-gap)
                make.bottom.equalTo(opImageView.snp.top).offset(-gap)
            }
            
            quitButton.snp.makeConstraints{ make in
                make.centerX.equalTo(view.snp.centerX)
                make.top.equalTo(myImageView.snp.bottom).offset(gap*5)
                make.height.equalTo(60)
                make.width.equalTo(150)
            }
            quitButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
            
        case .none:
            break
        }
        
        
    }
    
    @objc func quit(sender: UIButton){
        buttonAnimate(button: sender, shadow: .shadowcolor)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
}
