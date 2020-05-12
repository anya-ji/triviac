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
    
    let padding: CGFloat = 20
    
    let savedrid = "savedrid"
    
    let bgcolor = UIColor(red: 0.34, green: 0.34, blue: 0.38, alpha: 1.00)
    let btcolor = UIColor(red: 0.39, green: 0.51, blue: 0.51, alpha: 1.00)
    
    // Instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    var saved: [TriviaObj] = []
    
    //handle long pressed
//    var longPressedEnabled = false


    
    //reload data each time
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        savedView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: load saved data
        let savedData = userDefaults.array(forKey: "data") as? [Data] ?? []
        for d in savedData {
            let triviaDecoded = try? PropertyListDecoder().decode(TriviaObj.self, from: d)
            saved.append(triviaDecoded!)
        }
        
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
    }
    
    //push edit
    @objc func pushEdit(){
        //        let editViewController = EditViewController(placeholder: "Triviac")
        let obj = TriviaObj(set: [], title: "Triviac")
        let editViewController = EditViewController(placeholder: obj, reedit: false)
       // editViewController!.delegate = self
        navigationController?.pushViewController(editViewController!, animated: true)
    }
    //addButton function
    @objc func add(){
        pushEdit()
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
        let editViewController = EditViewController(placeholder: selected, reedit: true)
       // editViewController!.delegate = self
        navigationController?.pushViewController(editViewController!, animated: true)
    }
}





