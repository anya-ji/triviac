//
//  EditViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

//update cell on change, cell -> edit
protocol QuestionChangedDelegate: class{
    func questionChanged(to newQuestion: Question, for cell: EditTableViewCell)
}


class EditViewController: UIViewController {
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let btcolor =  UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let createcolor = UIColor(red: 1.00, green: 0.75, blue: 0.27, alpha: 1.00)
    
    var titleView: UIView!
    var titleLabel: UILabel!
    var titleText: UITextField!
    var createView: UIView!
    
    var tableView: UITableView!
    let editrid = "editrid"
    
    var placeholder: TriviaObj!
    
    var doneButton: UIButton!
    var addButton: UIBarButtonItem!
    
    let gap: CGFloat = 10
    let ls: CGFloat = 25
    
    var questions: [Question]!
    var q = Question(q: "", tf: true)
    
    var reedit: Bool
    var isTF: Bool
    
    // instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    
    //delegate: pass created game to saved, edit->saved
    weak var delegate: GameChangedDelegate?
    
    //initialization
    init?(placeholder: TriviaObj, reedit: Bool, isTF: Bool){
        self.placeholder = placeholder
        self.reedit = reedit
        self.isTF = isTF
        func objtoquestion(for obj: TriviaObj) -> [Question] {
            var rs: [Question] = []
            for t in obj.set{
                rs.append(Question.init(q: t.question, tf: t.correct_answer == "True" ? true : false))
            }
            return rs
        }
        questions = objtoquestion(for: placeholder)
        if questions == [] {questions = [q]}
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgcolor
        
        //questions = [q]
        
        //MARK: addButton
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = addButton
        
        //MARK: Title
        //titleView
        titleView = UIView()
        titleView.backgroundColor = btcolor
        view.addSubview(titleView)
        
        //titlelabel
        titleLabel = UILabel()
        if reedit {
            titleLabel.text = placeholder.title
        } else {
        titleLabel.text = "Title"
        }
        titleLabel.textColor = .white
        titleLabel.font = UIFont.init(name: "Chalkduster", size: ls)
        titleLabel.textAlignment = .center
        titleView.addSubview(titleLabel)
        
        //titleText
        titleText = UITextField()
        titleText.backgroundColor = .white
        titleText.text = placeholder.title
        titleText.borderStyle = UITextField.BorderStyle.roundedRect
        titleText.textAlignment = .center
        titleText.font = UIFont.init(name: "ChalkboardSE-Regular", size: ls)
        titleText.textAlignment = .center
        if !reedit {
        titleView.addSubview(titleText)
        }
        
        
        //MARK: TableView
        tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.register(EditTableViewCell.self, forCellReuseIdentifier: editrid)
        tableView.dataSource = self
        tableView.delegate = self
        
        //MARK: createView
        createView = UIView()
        createView.backgroundColor = btcolor
        view.addSubview(createView)
        
        //MARK: doneButton
        doneButton = UIButton()
        if reedit {
            doneButton.setTitle("Save", for: .normal)
        } else {
            doneButton.setTitle("Create!", for: .normal)
        }
        doneButton.backgroundColor = createcolor
        doneButton.setTitleColor(.white, for: .normal)
        if reedit {
            doneButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        } else {
            doneButton.addTarget(self, action: #selector(create), for: .touchUpInside)
        }
        doneButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 40)
        doneButton.titleLabel?.textAlignment = .center
        doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        doneButton.layer.cornerRadius = 20
        doneButton.layer.borderWidth = 3
        doneButton.layer.borderColor = UIColor.white.cgColor
        createView.addSubview(doneButton)
        
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
            if reedit{
                make.centerY.equalTo(titleView.snp.centerY)
            } else {
            make.height.equalTo(30)
            }
            make.centerX.equalTo(view.snp.centerX)
        }
        
        if !reedit {
        titleText.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(gap)
            make.bottom.equalTo(titleView.snp.bottom).offset(-gap)
            make.leading.equalTo(titleView.snp.leading).offset(gap*3)
            make.trailing.equalTo(titleView.snp.trailing).offset(-gap*3)
        }
        }
        
        createView.snp.makeConstraints{ make in
            make.height.equalTo(100)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        doneButton.snp.makeConstraints{make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(createView.snp.top).offset(gap)
            make.bottom.equalTo(createView.snp.bottom).offset(-gap)
            make.leading.equalTo(createView.snp.leading).offset(gap*3)
            make.trailing.equalTo(createView.snp.trailing).offset(-gap*3)
        }
        doneButton.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(createView.snp.top)
        }
    }
    
    
    
    //MARK: add a new question
    @objc func add(){
        questions.append(q)
        tableView.reloadData()
    }
    
    //MARK: build up the set
    func make_set() -> TriviaObj{
        var set: [Trivia] = []
        for qn in questions{
            set.append(Trivia.init(question: qn.q, correct_answer: qn.tf ? "True" : "False"))
        }
        //MARK: make sure titles are not empty or overlap!
        if reedit{
            return TriviaObj.init(set: set, title: titleLabel.text!)
        } else {
        return TriviaObj.init(set: set, title: titleText.text!)
        }
    }
    
    
    //MARK: store the created set to userdefaults
    @objc func create(){
        let createdset = make_set()
        // let encoded = try? NSKeyedArchiver.archivedData(withRootObject: createdset, requiringSecureCoding: false)
        var data = userDefaults.array(forKey: "data") as? [Data] ?? []
        let createdsetEncoded = try? PropertyListEncoder().encode(createdset)
        data.append(createdsetEncoded!)
        //print(data)
        userDefaults.set(data, forKey: "data")
        
        //change saved view
        //        if let data = UserDefaults.standard.value(forKey: "data") as? Data  {
        //            var newgame: TriviaObj!
        //            newgame = try? PropertyListDecoder().decode(TriviaObj.self, from: data)
        delegate?.gameChanged(to: createdset)
        // }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: reedit
    @objc func save(){
        let createdset = make_set()
        //find the altered triviaObj
        var data = userDefaults.array(forKey: "data") as? [Data] ?? []
        var i = 0
        while i < data.count{
            let t = try? PropertyListDecoder().decode(TriviaObj.self, from: data[i])
            if titleLabel.text == t?.title{
                data.remove(at: i)
                break
            }
            i = i+1
        }
        let createdsetEncoded = try? PropertyListEncoder().encode(createdset)
        data.append(createdsetEncoded!)
        userDefaults.set(data, forKey: "data")
        //delegate?.gameChanged(to: createdset)
        navigationController?.popViewController(animated: true)
    }
    
}



//MARK: delegate extension, update questions array
extension EditViewController: QuestionChangedDelegate{
    func questionChanged(to newQuestion: Question, for cell: EditTableViewCell){
        if let indexPath = self.tableView.indexPath(for: cell){
            questions![indexPath.row] = newQuestion
        }
    }
}


//MARK: Tableview DataSource
extension EditViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: editrid, for: indexPath) as! EditTableViewCell
        let question = questions[indexPath.row]
        //MARK: register the delegate!
        cell.delegate = self
        cell.config(for: question)
        
        cell.selectionStyle = .none
        
        return cell
        
    }
}

//MARK: Tableview Delegate
extension EditViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

