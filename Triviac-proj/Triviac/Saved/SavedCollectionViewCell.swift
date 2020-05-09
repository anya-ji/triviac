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
    let gap: CGFloat = 10
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           titleLabel = UILabel()
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           titleLabel.contentMode = .scaleToFill
           titleLabel.layer.masksToBounds = true
           titleLabel.textAlignment = .center
           titleLabel.backgroundColor = .lightGray
           titleLabel.textColor = .white
           
           contentView.addSubview(titleLabel)
           
           setup()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       func setup(){
        titleLabel.snp.makeConstraints{make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(gap)
            make.bottom.equalTo(contentView.snp.bottom).offset(-gap)
            make.leading.equalTo(contentView.snp.leading).offset(gap)
            make.trailing.equalTo(contentView.snp.trailing).offset(-gap)
        }
       
       }
       
       func config(for info: TriviaObj){
        titleLabel.text = info.title
       }
       
}
