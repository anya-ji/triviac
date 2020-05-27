//
//  EditTableViewCell.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {
    
    let cellcolor = UIColor(red: 0.77, green: 0.76, blue: 0.78, alpha: 1.00)
    let btcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
       
    
    var qLabel: UILabel!
    var qText: UITextField!
    var tfButton: UIButton!
    
    let gap: CGFloat = 10
    let ls: CGFloat = 20
    
    //delegate: cell -> edit
    weak var delegate: QuestionChangedDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = cellcolor
        
        qLabel = UILabel()
        qLabel.text = "Question"
        qLabel.textColor = .white
        qLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        qLabel.textAlignment = .center
        contentView.addSubview(qLabel)
        
        qText = UITextField()
        qText.backgroundColor = .white
        qText.text = ""
        qText.borderStyle = UITextField.BorderStyle.roundedRect
        qText.textAlignment = .center
        qText.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        qText.textAlignment = .center
        contentView.addSubview(qText)
        qText.addTarget(self, action: #selector(instantSave), for: .editingChanged)
        
        tfButton = UIButton()
        //tfButton.setTitle("F", for: .normal)
        tfButton.backgroundColor = btcolor
        tfButton.setTitleColor(.white, for: .normal)
        tfButton.addTarget(self, action: #selector(tf), for: .touchUpInside)
        tfButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 30)
        tfButton.titleLabel?.textAlignment = .center
        tfButton.layer.cornerRadius = 15
        tfButton.layer.borderWidth = 1
        tfButton.layer.borderColor = UIColor.white.cgColor
        contentView.addSubview(tfButton)
        
        setup()
    }
    
    
    func setup(){
        //qText
        qText.snp.makeConstraints{ make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-gap*1.5)
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(gap*2.5)
        }
        //qLabel
        qLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(qText.snp.centerX)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(gap)
            make.bottom.equalTo(qText.snp.top).offset(-gap)
        }
        
        //tf
        tfButton.snp.makeConstraints{ make in
            make.centerY.equalTo(qText.snp.centerY)
            make.height.width.equalTo(50)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-gap*2.5)
        }
    }
    
    //save question and tf on change
    @objc func instantSave(){
        let updatedQuestion = Question.init(q: qText.text ?? "", tf: tfButton.titleLabel?.text == "T" ? true : false)
        delegate!.questionChanged(to: updatedQuestion, for: self)
    }
    
    @objc func tf(){
        if tfButton.titleLabel?.text == "T" {
            tfButton.setTitle("F", for: .normal)
        } else{
             tfButton.setTitle("T", for: .normal)
        }
        instantSave()
    }
    
    func config(for question: Question){
        qText.text = question.q
        let bt = question.tf ? "T" : "F"
        tfButton.setTitle(bt, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
