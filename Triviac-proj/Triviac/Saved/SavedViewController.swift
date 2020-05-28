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
        
        navigationController?.navigationBar.barTintColor = barcolor
        navigationController?.navigationBar.titleTextAttributes = [
                  // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                   NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white

        //view.backgroundColor = bgcolor
        self.title = "Saved"
        
       
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
        let playViewController = PlayViewController(mode: selected.set[0].type, replay: selected)
        navigationController?.pushViewController(playViewController, animated: true)
    }
}





