//
//  EditViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    let bgcolor = UIColor(red: 0.34, green: 0.34, blue: 0.38, alpha: 1.00)
    let btcolor = UIColor(red: 0.39, green: 0.51, blue: 0.51, alpha: 1.00)
    
    var titleView: UIView!
    var titleLabel: UILabel!
    var titleText: UITextField!
    
    var tableView: UITableView!
    let editrid = "editrid"
    
    
    var doneButton: UIBarButtonItem!
    
    let gap: CGFloat = 10
    let ls: CGFloat = 25
    
    var questions: [Question]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgcolor
        
        let q1 = Question(q: "a", tf: true)
        let q2 = Question(q: "b", tf: true)
        questions = [q1, q2]
        
        //MARK: saveButton
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = doneButton
        
        //MARK: Title
        //titleView
        titleView = UIView()
        titleView.backgroundColor = btcolor
        view.addSubview(titleView)
        
        //titlelabel
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        
        //titleText
        titleText = UITextField()
        titleText.backgroundColor = .white
        titleText.text = "Triviac"
        titleText.borderStyle = UITextField.BorderStyle.roundedRect
        titleText.textAlignment = .center
        titleText.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        titleText.textAlignment = .center
        titleView.addSubview(titleText)
        
        //MARK: TableView
        tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.register(EditTableViewCell.self, forCellReuseIdentifier: editrid)
        tableView.dataSource = self
        tableView.delegate = self
        
        setup()
    }
    
    func setup(){
        titleView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(gap)
            make.height.equalTo(30)
            make.centerX.equalTo(view.snp.centerX)
        }
        titleText.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(gap)
            make.bottom.equalTo(titleView.snp.bottom).offset(-gap)
            make.leading.equalTo(titleView.snp.leading).offset(gap*3)
            make.trailing.equalTo(titleView.snp.trailing).offset(-gap*3)
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    @objc func done(){
        //           if let changedName = nameField.text, changedName != ""{
        //               delegate?.redTextChanged(to: changedName)
        //           }
        //dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: DataSource
extension EditViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: editrid, for: indexPath) as! EditTableViewCell
        let question = questions[indexPath.row]
        
        cell.config(for: question)
        
        cell.selectionStyle = .none
        
        return cell
        
    }
}

//MARK: Delegate
extension EditViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

