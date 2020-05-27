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


class SavedViewController: UIViewController, UIGestureRecognizerDelegate {
    var savedView: UICollectionView!
    var addButton: UIBarButtonItem!
    
    var modeView: UIView!
    var tf: UIButton!
    var mc: UIButton!
    var prompt: UILabel!
    
    let padding: CGFloat = 20
    
    let savedrid = "savedrid"
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let barcolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    
    // Instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    var saved: [TriviaObj] = []
    
    //handle long pressed
//    var longPressedEnabled = false


    
    //reload data each time
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        
        navigationController?.navigationBar.barTintColor = barcolor
        navigationController?.navigationBar.titleTextAttributes = [
                  // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white

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
        flayout.sectionInset.left = padding
        flayout.sectionInset.right = padding
        flayout.sectionInset.top = padding
        flayout.sectionInset.bottom = padding
        
        savedView = UICollectionView(frame: .zero, collectionViewLayout: flayout)
        savedView.backgroundColor = bgcolor
        view.addSubview(savedView)
        
        savedView.register(SavedCollectionViewCell.self, forCellWithReuseIdentifier: savedrid)
        savedView.dataSource = self
        savedView.delegate = self
        
        //choose mode
        modeView = UIView()
        modeView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        modeView.layer.cornerRadius = 10
        view.addSubview(modeView)
        modeView.isHidden = true
        
        tf = UIButton()
        tf.setTitle("True/False", for: .normal)
        tf.backgroundColor = barcolor
        tf.setTitleColor(.white, for: .normal)
        tf.addTarget(self, action: #selector(chosenMode), for: .touchUpInside)
        tf.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        tf.titleLabel?.textAlignment = .center
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.white.cgColor
        tf.titleLabel?.adjustsFontSizeToFitWidth = true
        modeView.addSubview(tf)
        
        mc = UIButton()
        mc.setTitle("Multiple Choice", for: .normal)
        mc.backgroundColor = barcolor
        mc.setTitleColor(.white, for: .normal)
        mc.addTarget(self, action: #selector(chosenMode), for: .touchUpInside)
        mc.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        mc.titleLabel?.textAlignment = .center
        mc.layer.cornerRadius = 15
        mc.layer.borderWidth = 1
        mc.layer.borderColor = UIColor.white.cgColor
        mc.titleLabel?.adjustsFontSizeToFitWidth = true
        modeView.addSubview(mc)
        
        prompt = UILabel()
        prompt.text = "Choose the type of questions you want to create:"
        prompt.textColor = .white
        prompt.font = UIFont.init(name: "Chalkduster", size: 20)
        prompt.textAlignment = .center
        prompt.adjustsFontSizeToFitWidth = true
        prompt.lineBreakMode = .byWordWrapping
        prompt.numberOfLines = 0
        modeView.addSubview(prompt)
        
        setup()
        
        //MARK: long pressed
        // Add gesture recognizer to collection view cell
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
//        savedView.addGestureRecognizer(longPressGesture)
        
    }
    
//    @objc func longTap(_ gesture: UIGestureRecognizer){
//
//        switch(gesture.state) {
//        case .began:
//            guard let selectedIndexPath = savedView.indexPathForItem(at: gesture.location(in: savedView)) else {
//                return
//            }
//            savedView.beginInteractiveMovementForItem(at: selectedIndexPath)
//        case .changed:
//            savedView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
//        case .ended:
//            savedView.endInteractiveMovement()
//            //doneBtn.isHidden = false
//            longPressedEnabled = true
//            self.savedView.reloadData()
//        default:
//            savedView.cancelInteractiveMovement()
//        }
//    }
//
    
//    @IBAction func removeBtnClick(_ sender: UIButton)   {
//        let hitPoint = sender.convert(CGPoint.zero, to: savedView)
//        let hitIndex = savedView.indexPathForItem(at: hitPoint)
//
//        //remove the image and refresh the collection view
//        //self.imgArr.remove(at: (hitIndex?.row)!)
//        self.savedView.reloadData()
//    }
//
//    @IBAction func doneBtnClick(_ sender: UIButton) {
//        //disable the shake and hide done button
//        //doneBtn.isHidden = true
//        longPressedEnabled = false
//
//        self.savedView.reloadData()
//    }
    
    
    
    func setup(){
        savedView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        modeView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        tf.snp.makeConstraints{make in
            make.height.equalTo(80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        tf.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        mc.snp.makeConstraints{make in
            make.height.equalTo(80)
            make.leading.equalTo(view.snp.centerX).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            
        }
        mc.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        prompt.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(view.snp.centerY)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    //addButton function
    @objc func add(){
        modeView.isHidden = false
    }
    //choose mode
    @objc func chosenMode(sender: UIButton){
        modeView.isHidden = true
        let obj = TriviaObj(set: [], title: "Triviac")
        if sender.titleLabel?.text == "True/False"{
            let editViewController = EditViewController(placeholder: obj, reedit: false, isTF: true)
            navigationController?.pushViewController(editViewController!, animated: true)
        }
        else{
            let editViewController = EditViewController(placeholder: obj, reedit: false, isTF: false)
            navigationController?.pushViewController(editViewController!, animated: true)
        }
        
    }
    
    
}
//MARK: Gamechange delegate (saved created)
//extension SavedViewController: GameChangedDelegate{
//    func gameChanged(to newGame: TriviaObj) {
//        //saved.append(newGame)
//        savedView.reloadData()
//        //print(saved)
//    }
//}

//MARK: Collectionview extensions
extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (savedView.frame.width - 3 * padding)/2.0
        return CGSize(width: w, height: 180)
    }
}

extension SavedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savedView.dequeueReusableCell(withReuseIdentifier: savedrid, for: indexPath) as! SavedCollectionViewCell
        let game = saved[indexPath.item]
        cell.config(for: game)
        
        //MARK: long pressed and delete
//        cell.removeBtn.addTarget(self, action: #selector(removeBtnClick(_:)), for: .touchUpInside)
//
//        if longPressedEnabled   {
//            cell.startAnimate()
//        }else{
//            cell.stopAnimate()
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saved.count
    }
    
}

extension SavedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = saved[indexPath.item]
        let editViewController = EditViewController(placeholder: selected, reedit: true, isTF: selected.set[0].type == "boolean")
       // editViewController!.delegate = self
        navigationController?.pushViewController(editViewController!, animated: true)
    }
}





