//
//  SavedCollectionViewCell.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class SavedCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var catLabel: UILabel!
    var difLabel: UILabel!
    var typLabel: UILabel!
    var highest: UILabel!
    
    var id: Date!
    
    var deleteButton: UIButton!
    
    let gap: CGFloat = 10
    let pad: CGFloat = 1
    let h: CGFloat = 30
    
    var isAnimate: Bool! = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
        layer.cornerRadius = 10
        backgroundColor = .accentbuttoncolor
        
        titleLabel = UILabel()
        titleLabel.contentMode = .scaleToFill
        titleLabel.layer.masksToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.init(name: "Chalkduster", size: 20)
        contentView.addSubview(titleLabel)
        
        catLabel = UILabel()
        catLabel.contentMode = .scaleToFill
        catLabel.layer.masksToBounds = true
        catLabel.textAlignment = .center
        catLabel.textColor = .white
        catLabel.adjustsFontSizeToFitWidth = true
        catLabel.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        contentView.addSubview(catLabel)
        
        difLabel = UILabel()
        difLabel.contentMode = .scaleToFill
        difLabel.layer.masksToBounds = true
        difLabel.textAlignment = .center
        difLabel.textColor = .white
        difLabel.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        contentView.addSubview(difLabel)
        
        typLabel = UILabel()
        typLabel.contentMode = .scaleToFill
        typLabel.layer.masksToBounds = true
        typLabel.textAlignment = .center
        typLabel.textColor = .white
        typLabel.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        contentView.addSubview(typLabel)
        
        highest = UILabel()
        highest.contentMode = .scaleToFill
        highest.layer.masksToBounds = true
        highest.textAlignment = .center
        highest.textColor = .orange
        highest.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        contentView.addSubview(highest)
        
        deleteButton = UIButton()
        let delete = UIImage(named: "delete")
        deleteButton.setImage(delete, for: .normal)
        deleteButton.isHidden = true
        contentView.addSubview(deleteButton)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Animation of image
        func startAnimate() {
                let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
                shakeAnimation.duration = 0.05
                shakeAnimation.repeatCount = 4
                shakeAnimation.autoreverses = true
                shakeAnimation.duration = 0.15
                shakeAnimation.repeatCount = 99999
    
                let startAngle: Float = (-1) * 3.14159/180
                let stopAngle = -startAngle
    
                shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
                shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
                shakeAnimation.autoreverses = true
                shakeAnimation.timeOffset = 290 * drand48()
    
                let layer: CALayer = self.layer
                layer.add(shakeAnimation, forKey:"animate")
                deleteButton.isHidden = false
                isAnimate = true
            }
    
        func stopAnimate() {
            let layer: CALayer = self.layer
            layer.removeAnimation(forKey: "animate")
            deleteButton.isHidden = true
            isAnimate = false
        }
    
    func setup(){
        titleLabel.snp.makeConstraints{make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(gap)
            make.height.equalTo(h)
            make.leading.equalTo(contentView.snp.leading).offset(gap)
            make.trailing.equalTo(contentView.snp.trailing).offset(-gap)
        }
        
        
        highest.snp.makeConstraints{make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(-gap)
            make.height.equalTo(h)
            make.leading.equalTo(contentView.snp.leading).offset(gap)
            make.trailing.equalTo(contentView.snp.trailing).offset(-gap)
        }
        
        typLabel.snp.makeConstraints{make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(highest.snp.top).offset(-pad)
            make.height.equalTo(h)
            make.leading.equalTo(contentView.snp.leading).offset(gap)
            make.trailing.equalTo(contentView.snp.trailing).offset(-gap)
        }
        
        difLabel.snp.makeConstraints{make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(typLabel.snp.top).offset(-pad)
            make.height.equalTo(h)
            make.leading.equalTo(contentView.snp.leading).offset(gap)
            make.trailing.equalTo(contentView.snp.trailing).offset(-gap)
        }
        
        catLabel.snp.makeConstraints{make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(difLabel.snp.top).offset(-pad)
            make.height.equalTo(h)
            make.leading.equalTo(contentView.snp.leading).offset(gap)
            make.trailing.equalTo(contentView.snp.trailing).offset(-gap)
        }
        
        
        deleteButton.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(20)
            make.leading.equalToSuperview().offset(10)
        }
        
        
        
    }
    
    func config(for info: TriviaObj){
        id = info.id
        titleLabel.text = info.title
        catLabel.text = info.category
        if info.difficulty == "easy"{
            difLabel.text = "Easy"
        } else if info.difficulty == "medium"{
            difLabel.text = "Medium"
        } else {
            difLabel.text = "Hard"
        }
        
        if info.type == "multiple"{
            typLabel.text = "Multiple Choice"
        } else {
            typLabel.text = "True/False"
        }
        
        highest.text = "Highest Score: \(info.score)"
    }
    
    
}

