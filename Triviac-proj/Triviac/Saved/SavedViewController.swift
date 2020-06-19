//
//  SavedViewController.swift
//  Triviac
//
//  Created by Anya Ji on 5/4/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController, UIGestureRecognizerDelegate {
    var savedView: UICollectionView!
    
    var done: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    
    let padding: CGFloat = 20
    
    let savedrid = "savedrid"
    
    // Instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    var saved: [TriviaObj] = []
    
    //handle long pressed
    var longPressedEnabled = false
    
    var sureView: UIView!
    var delete: UIButton!
    var cancel: UIButton!
    var prompt: UILabel!
    var chosensender: UIButton!
    
    //reload data each time
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //MARK: ensure top and bottom bars are always present
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = false
        //MARK: load saved data
        saved = []
        let savedData = userDefaults.array(forKey: "data") as? [Data] ?? []
        for d in savedData {
            if let triviaDecoded = try? PropertyListDecoder().decode(TriviaObj.self, from: d){
                saved.append(triviaDecoded)}
        }
        savedView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .accentbuttoncolor
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        //view.backgroundColor = bgcolor
        self.navigationItem.title = "Saved"
        
        
        //filter layout, view
        let flayout = UICollectionViewFlowLayout()
        flayout.scrollDirection = .vertical
        flayout.minimumInteritemSpacing = padding
        flayout.minimumLineSpacing = padding
        flayout.sectionInset.left = padding
        flayout.sectionInset.right = padding
        flayout.sectionInset.top = padding
        flayout.sectionInset.bottom = padding
        
        savedView = UICollectionView(frame: .zero, collectionViewLayout: flayout)
        savedView.backgroundColor = .bgcolor
        view.addSubview(savedView)
        
        savedView.register(SavedCollectionViewCell.self, forCellWithReuseIdentifier: savedrid)
        savedView.dataSource = self
        savedView.delegate = self
        
        done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEdit))
        done.isEnabled = false
        done.tintColor = .clear
        self.navigationItem.rightBarButtonItem = done
        
        let editimg = UIImage(named: "edit")?.resized(to: CGSize(width: 25, height: 25))
        editButton = UIBarButtonItem(image: editimg, style: .done, target: self, action: #selector(edit))
        editButton.isEnabled = true
        editButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = editButton
        
        
        
        //ask when delete
        sureView = UIView()
        sureView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        sureView.layer.cornerRadius = 10
        view.addSubview(sureView)
        sureView.isHidden = true
        
        delete = UIButton()
        delete.setTitle("Delete", for: .normal)
        delete.backgroundColor = .accentbuttoncolor
        delete.setTitleColor(.white, for: .normal)
        delete.addTarget(self, action: #selector(check), for: .touchUpInside)
        delete.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        delete.titleLabel?.textAlignment = .center
        delete.layer.cornerRadius = 15
        delete.layer.borderWidth = 1
        delete.layer.borderColor = UIColor.white.cgColor
        delete.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: delete, shadow: .gray)
        sureView.addSubview(delete)
        
        cancel = UIButton()
        cancel.setTitle("Cancel", for: .normal)
        cancel.backgroundColor = .lightGray
        cancel.setTitleColor(.white, for: .normal)
        cancel.addTarget(self, action: #selector(check), for: .touchUpInside)
        cancel.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        cancel.titleLabel?.textAlignment = .center
        cancel.layer.cornerRadius = 15
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor.white.cgColor
        cancel.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: cancel, shadow: .gray)
        sureView.addSubview(cancel)
        
        prompt = UILabel()
        prompt.text = "Are you sure?"
        prompt.textColor = .lightGray
        prompt.font = UIFont.init(name: "Chalkduster", size: 20)
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        sureView.addSubview(prompt)
        
        //MARK: long pressed
        // Add gesture recognizer to collection view cell
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        savedView.addGestureRecognizer(longPress)
        setup()
    }
    
    @objc func check(sender: UIButton){
        buttonAnimate(button: sender, shadow: .gray)
        if sender.titleLabel?.text == "Delete"{
            let hitPoint = chosensender.convert(CGPoint.zero, to: self.savedView)
            let hitIndex = self.savedView.indexPathForItem(at: hitPoint)
            
            //delete from userdefault
            var data = self.userDefaults.array(forKey: "data") as? [Data] ?? []
            var i = 0
            let id = self.saved[hitIndex!.item].id
            while i < data.count{
                let t = try? PropertyListDecoder().decode(TriviaObj.self, from: data[i])
                if  id == t?.id{
                    data.remove(at: i)
                    break
                }
                i = i+1
            }
            self.userDefaults.set(data, forKey: "data")
            
            self.saved.remove(at: hitIndex!.item)
            self.savedView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.sureView.isHidden = true
        }
    }
    
    
    
    @objc func edit(){
        done.isEnabled = true
        done.tintColor = .white
        longPressedEnabled = true
        self.savedView.reloadData()
        editButton.isEnabled = false
        editButton.tintColor = .clear
        savedView.allowsSelection = false
    }
    
    @objc func doneEdit(){
        longPressedEnabled = false
        self.savedView.reloadData()
        done.isEnabled = false
        done.tintColor = .clear
        editButton.isEnabled = true
        editButton.tintColor = .white
        savedView.allowsSelection = true
    }
    
    @objc func longPress(sender: UIGestureRecognizer){
        savedView.allowsSelection = false
        switch(sender.state) {
        case .began:
            guard let selectedIndexPath = savedView.indexPathForItem(at:sender.location(in: savedView)) else {
                return
            }
            savedView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            savedView.updateInteractiveMovementTargetPosition(sender.location(in: sender.view!))
        case .ended:
            savedView.endInteractiveMovement()
            done.isEnabled = true
            done.tintColor = .white
            editButton.isEnabled = false
            editButton.tintColor = .clear
            longPressedEnabled = true
            self.savedView.reloadData()
        default:
            savedView.cancelInteractiveMovement()
        }
    }
    
    
    
    func setup(){
        savedView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        sureView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.height.equalTo(220)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        delete.snp.makeConstraints{make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalTo(sureView.snp.centerX).offset(-20)
        }
        delete.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        cancel.snp.makeConstraints{make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalTo(sureView.snp.centerX).offset(20)
        }
        cancel.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        prompt.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(delete.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
    }
    
}


//MARK: Collectionview extensions
extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = savedView.frame.width - 2 * padding
        return CGSize(width: w, height: 180)
    }
}

extension SavedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savedView.dequeueReusableCell(withReuseIdentifier: savedrid, for: indexPath) as! SavedCollectionViewCell
        let game = saved[indexPath.item]
        cell.config(for: game)
        
        //MARK: long pressed and delete
        cell.deleteButton.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        if longPressedEnabled   {
            cell.startAnimate()
        }else{
            cell.stopAnimate()
        }
        return cell
    }
    
    @objc func deleteCell(sender: UIButton) {
        sureView.isHidden = false
        chosensender = sender
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saved.count
    }
    
}

extension SavedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = saved[indexPath.item]
        let playViewController = PlayViewController(mode: selected.set[0].type, replay: selected)
        navigationController?.pushViewController(playViewController, animated: true)
    }
}





