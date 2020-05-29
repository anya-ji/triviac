//
//  CatTableViewCell.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    
    var catLabel: UILabel!
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
  
    let gap: CGFloat = 10
    let ls: CGFloat = 20
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = bgcolor
        
        catLabel = UILabel()
        catLabel.textColor = .white
        catLabel.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        catLabel.textAlignment = .center
        catLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(catLabel)
      
        catLabel.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().offset(-gap)
            make.height.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(for cat: String){
        catLabel.text = cat
    }
}
