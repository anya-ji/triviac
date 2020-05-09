//
//  SavedViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/4/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

//pass info to savedview cell labels edit -> saved
protocol GameChangedDelegate: class {
    func gameChanged(to newGame: TriviaObj)
}


class SavedViewController: UIViewController {
    var savedView: UICollectionView!
    var addButton: UIBarButtonItem!
    
    let padding: CGFloat = 5
    
    let savedrid = "savedrid"
    
    let bgcolor = UIColor(red: 0.34, green: 0.34, blue: 0.38, alpha: 1.00)
    let btcolor = UIColor(red: 0.39, green: 0.51, blue: 0.51, alpha: 1.00)
    
    var saved: [TriviaObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = bgcolor
        self.title = "Saved"
        
        //add button
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.leftBarButtonItem = addButton
        
        //filter layout, view
        let flayout = UICollectionViewFlowLayout()
        flayout.scrollDirection = .vertical
        flayout.minimumInteritemSpacing = padding
        flayout.minimumLineSpacing = padding
        
       savedView = UICollectionView(frame: .zero, collectionViewLayout: flayout)
        savedView.backgroundColor = bgcolor
        view.addSubview(savedView)
        
        savedView.register(SavedCollectionViewCell.self, forCellWithReuseIdentifier: savedrid)
        savedView.dataSource = self
        savedView.delegate = self
        
        setup()
    }
    
    func setup(){
        savedView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    //push edit
    @objc func pushEdit(){
//        let editViewController = EditViewController(placeholder: "Triviac")
        let obj = TriviaObj(set: [], title: "Triviac")
        let editViewController = EditViewController(placeholder: obj)
        editViewController!.delegate = self
        navigationController?.pushViewController(editViewController!, animated: true)
    }
    //addButton function
    @objc func add(){
        pushEdit()
    }
    
}
//MARK: Gamechange delegate (saved created)
extension SavedViewController: GameChangedDelegate{
    func gameChanged(to newGame: TriviaObj) {
        saved.append(newGame)
        savedView.reloadData()
        print(saved)
    }
}

//MARK: Collectionview extensions
extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let w = (savedView.frame.width - 3 * padding)/2.0
            return CGSize(width: w, height: 200)
    }
}

extension SavedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savedView.dequeueReusableCell(withReuseIdentifier: savedrid, for: indexPath) as! SavedCollectionViewCell
         let game = saved[indexPath.item]
         cell.config(for: game)
         return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saved.count
    }
}

extension SavedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = saved[indexPath.item]
        let editViewController = EditViewController(placeholder: selected)
        editViewController!.delegate = self
        navigationController?.pushViewController(editViewController!, animated: true)
    }
}



