//
//  JoinTableViewCell.swift
//  Triviac
//
//  Created by Anya Ji on 6/11/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class JoinTableViewCell: UITableViewCell {
    var nameLabel: UILabel!
    var photo: UIImageView!
    var pointsLabel: UILabel!
    
    let gap: CGFloat = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .bgcolor
        
        photo = UIImageView()
        photo.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        photo.backgroundColor = .clear
        contentView.addSubview(photo)
        
        photo.snp.makeConstraints{ make in
            make.height.width.equalTo(50)
            make.leading.equalToSuperview().offset(gap*3)
            make.centerY.equalToSuperview()
            
            
        }
        
        
        
        pointsLabel = UILabel()
        pointsLabel.textColor = .accentbuttoncolor
        pointsLabel.font = UIFont.init(name: "Chalkduster", size: 16)
        pointsLabel.textAlignment = .left
        pointsLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(pointsLabel)
        
        pointsLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-gap*2)
            make.height.equalToSuperview()
            make.width.equalTo(60)
            
        }
        
        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.init(name: "Chalkduster", size: 20)
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(photo.snp.trailing).offset(gap*3)
            make.trailing.equalTo(pointsLabel.snp.leading).offset(-gap)
            make.height.equalToSuperview()
            
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with host: Player) {
        nameLabel.text = host.name
        photo.tintColor = UIColor.init(hex: host.color)
        pointsLabel.text = "\(host.points ?? 0) pts"
    }
    
}
