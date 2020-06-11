//
//  InviteViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/9/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {
    
    var mode: String!
    var replay: TriviaObj!
    
    var playerlist: [Player]! = []
    
    var addedTableView: UITableView!
    var gen: UIButton!
    var addButton: UIBarButtonItem!
    
    let rid = "inviteReuseIdentifier"
    
    init(mode: String, replay: TriviaObj?){
           super.init(nibName: nil, bundle: nil)
           self.mode = mode
           self.replay = replay
            
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgcolor
        self.navigationItem.title = "Invite"
        navigationController?.navigationBar.barTintColor = .customyellow
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushSearch))
        self.navigationItem.rightBarButtonItem = addButton
        
        addedTableView = UITableView()
        addedTableView.backgroundColor = .bgcolor
        view.addSubview(addedTableView)
        

        addedTableView.register(InviteTableViewCell.self, forCellReuseIdentifier: rid)
        addedTableView.dataSource = self
        addedTableView.delegate = self
        
        
        //gen
        gen = UIButton()
        gen.setTitle("Generate!", for: .normal)
        gen.backgroundColor = .customyellow
        gen.setTitleColor(.white, for: .normal)
        gen.addTarget(self, action: #selector(genf), for: .touchUpInside)
        gen.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 25)
        gen.titleLabel?.textAlignment = .center
        gen.layer.cornerRadius = 20
        gen.layer.borderWidth = 3
        gen.layer.borderColor = UIColor.white.cgColor
        gen.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: gen, shadow: .shadowcolor)
        view.addSubview(gen)
        
        
        setup()
    }
    
    func setup(){
        let gap = view.frame.height / 83
        
        addedTableView.snp.makeConstraints{make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        //gen
        gen.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-gap*5)
            //make.top.equalTo(typ.snp.bottom).offset(gap*3)
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        gen.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
    }
    
    @objc func genf(){
        let playViewController = PlayViewController(mode: mode, replay: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.pushViewController(playViewController, animated: true)
        }
    }
    
    @objc func pushSearch(){
        let searchVC = SearchViewController(fromVC: self)
        present(searchVC, animated: true, completion: nil)
    }

}

extension InviteViewController: ResultTableViewCellDelegate {
    func resultTableViewCellDidTapAddButton(result: Player) {
        playerlist.append(result)
        addedTableView.reloadData()
    }
    
}

extension InviteViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(playerlist.count)
        return playerlist.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rid, for: indexPath) as! InviteTableViewCell
        let player = playerlist[indexPath.row]
        
        cell.configure(with: player)
        
        return cell
        
    }
    
    
    
}

extension InviteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//back button without text
extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}



