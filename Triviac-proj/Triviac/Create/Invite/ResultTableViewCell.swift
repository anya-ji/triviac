//
//  ResultTableViewCell.swift
//  Triviac
//
//  Created by Anya Ji on 6/9/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

protocol ResultTableViewCellDelegate: class {
    
    func resultTableViewCellDidTapAddButton(result: Player)
    
}

class ResultTableViewCell: UITableViewCell {
    
    //var photo: UIImageView!
    var nameLabel: UILabel!
    
    var addplayer: Player!
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    
    let gap: CGFloat = 10
    let ls: CGFloat = 20
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = bgcolor
        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.height.equalToSuperview()
            
        }
    }
    
    
    
    func configure(with addplayer: Player) {
        self.addplayer = addplayer
        nameLabel.text = addplayer.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


