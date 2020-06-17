//
//  InviteTableViewCell.swift
//  Triviac
//
//  Created by Anya Ji on 6/11/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class InviteTableViewCell: UITableViewCell {
     var nameLabel: UILabel!
    
    var joinedLabel: UILabel!
    
    let gap: CGFloat = 10
    let ls: CGFloat = 20
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .bgcolor
        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.height.equalToSuperview()
            
        }
        
        joinedLabel = UILabel()
        joinedLabel.textColor = .customyellow
        joinedLabel.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls-5)
        joinedLabel.textAlignment = .right
        joinedLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(joinedLabel)
        
        joinedLabel.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.height.equalToSuperview()
            
        }
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func configure(with selectedplayerName: String, accepted: Bool) {
        nameLabel.text = selectedplayerName
        joinedLabel.isHidden = !accepted
    }
   
}
