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
    var addButton: UIButton!
    
    var addplayer: Player!
    
    let gap: CGFloat = 10
    let ls: CGFloat = 20
    
    let addButtonHeight: CGFloat = 25
    let addButtonTitle = "Add"
    
   weak var delegate: ResultTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .bgcolor
        
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
        
        addButton = UIButton()
               addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
               addButton.layer.cornerRadius = addButtonHeight / 2
        addButton.backgroundColor = .customyellow
               addButton.setTitle(addButtonTitle, for: .normal)
               addButton.setTitleColor(.white, for: .normal)
               addButton.titleLabel?.textAlignment = .center
               addButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
               contentView.addSubview(addButton)
        
    
        addButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(addButtonHeight)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(8)
        }
        
    }
    
    @objc func addButtonPressed() {
        delegate?.resultTableViewCellDidTapAddButton(result: addplayer)
    }
    
    func configure(with addplayer: Player, delegate: InviteViewController) {
        self.addplayer = addplayer
        self.delegate = delegate
        nameLabel.text = addplayer.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


