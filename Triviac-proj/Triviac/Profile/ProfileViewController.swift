//
//  ProfileViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/8/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    var exitButton: UIBarButtonItem!
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let barcolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    
    var topView: UIView!
    
    var player: Player?
    var photo: UIImageView!
    var nameLabel: UILabel!
    var percent: UILabel!
    var bulb: UIImageView!
    var points: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        checkLoggedIn()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        navigationController?.navigationBar.barTintColor = barcolor
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        view.backgroundColor = bgcolor
        self.navigationItem.title = "Profile"
        
        topView = UIView()
        topView.backgroundColor = .shadowcolor
        view.addSubview(topView)

        let exitimg = UIImage(named: "exit")?.resized(to: CGSize(width: 30, height: 30))
        exitButton = UIBarButtonItem(image: exitimg, style: .done, target: self, action: #selector(exit))
        exitButton.isEnabled = true
        exitButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = exitButton
        
        photo = UIImageView()
        photo.image = UIImage(named: "head")?.withRenderingMode(.alwaysTemplate)
        photo.backgroundColor = .clear
        photo.tintColor = .clear
        topView.addSubview(photo)
        
        nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.init(name: "Chalkduster", size: 20)
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        topView.addSubview(nameLabel)
        
        bulb = UIImageView()
        bulb.image = UIImage(named: "bulb")
        view.addSubview(bulb)
        
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        photo.makeRounded()
    }
    
    
    func setup(){
        let gap = view.frame.height / 50
//        photo.snp.makeConstraints{ make in
//            make.trailing.equalTo(view.snp.centerX).offset(-gap*2)
//            make.height.width.equalTo(80)
//            make.bottom.equalTo(view.snp.centerY).offset(-gap*3)
//        }
//
//        nameLabel.snp.makeConstraints{ make in
//            make.leading.equalTo(view.snp.centerX)
//            make.top.equalTo(photo.snp.top)
//            make.bottom.equalTo(photo.snp.centerY)
//            make.trailing.equalToSuperview()
//        }
//
//        bulb.snp.makeConstraints{ make in
//            make.leading.equalTo(view.snp.centerX).offset(gap*2)
//            make.height.width.equalTo(100)
//            make.top.equalTo(view.snp.centerY).offset(gap*3)
//
//        }
        topView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.centerY).offset(-gap*4)
        }
        photo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(gap*3)
            make.height.width.equalTo(80)
            make.centerX.equalToSuperview()
            }
            
            nameLabel.snp.makeConstraints{ make in
                make.top.equalTo(photo.snp.bottom).offset(gap)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
            }
            
            bulb.snp.makeConstraints{ make in
                make.leading.equalTo(view.snp.centerX).offset(gap*2)
                make.height.width.equalTo(100)
                make.top.equalTo(view.snp.centerY).offset(gap*3)
        
            }
    }
    
    func checkLoggedIn(){
        //user is not logged in, check if they are logged in, try log out if not
        if Auth.auth().currentUser?.uid == nil {
            exit()
        }
        else{
            
            let uid = Auth.auth().currentUser?.uid
            //print(uid!)
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot.value)
                if let dict = snapshot.value as? [String: Any]{
                    self.player = Player.fromDatabase(object: dict)
                    self.nameLabel.text = self.player!.name
                    self.photo.tintColor = UIColor(hex: self.player!.color)
                    self.photo.backgroundColor = .shadowcolor
                    self.view.setNeedsDisplay()
                    self.view.layoutIfNeeded()
                    //print(dict)
                }
            }, withCancel: nil)
        }
    }
    
    @objc func exit(){
        //user is not logged in
        do{
            try Auth.auth().signOut()
        } catch let logoutError{
            print(logoutError)
        }
        
        let signInViewController = SignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    

}

extension NSMutableAttributedString {

    func setColorFont(color: UIColor, font: UIFont, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font], range: range)
    }

}

//rounded photo
extension UIImageView {

    func makeRounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.customyellow.cgColor
        self.clipsToBounds = true
    }
}
