//
//  SignInViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class SignInViewController: UIViewController {
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let gencolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    let btcolor = UIColor(red: 0.77, green: 0.76, blue: 0.78, alpha: 1.00)
    let textcolor = UIColor.white
    let bordercolor = UIColor.white
    let shadowcolor = UIColor(red: 0.15, green: 0.16, blue: 0.16, alpha: 1.00)
    
    let gap: CGFloat = 20
    
    var sc: UISegmentedControl!
    var userText: UITextField!
    var pwText: UITextField!
    var emailText: UITextField!
    var signInRegisterButton: UIButton!
    var bulb: UIImageView!
    
    // Instantiate UserDefaults
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = bgcolor
        self.navigationItem.title = "Sign In"
        navigationController?.navigationBar.barTintColor = gencolor
        navigationController?.navigationBar.titleTextAttributes = [
            // NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        
        sc = UISegmentedControl(items: ["Sign In", "Register"])
        sc.tintColor = .white
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: bgcolor], for: .selected)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handle), for: .valueChanged)
        view.addSubview(sc)
        
        userText = UITextField()
        userText.backgroundColor = .white
        userText.placeholder = "Username"
        userText.textColor = .black
        userText.borderStyle = UITextField.BorderStyle.roundedRect
        userText.textAlignment = .left
        userText.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        view.addSubview(userText)
        
        pwText = UITextField()
        pwText.backgroundColor = .white
        pwText.placeholder = "Password"
        pwText.textColor = .black
        pwText.borderStyle = UITextField.BorderStyle.roundedRect
        pwText.textAlignment = .left
        pwText.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        pwText.isSecureTextEntry = true
        view.addSubview(pwText)
        
        emailText = UITextField()
        emailText.backgroundColor = .white
        emailText.placeholder = "Email Address"
        emailText.textColor = .black
        emailText.borderStyle = UITextField.BorderStyle.roundedRect
        emailText.textAlignment = .left
        emailText.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        view.addSubview(emailText)
        
        signInRegisterButton = UIButton()
        signInRegisterButton.setTitle("Sign In", for: .normal)
        signInRegisterButton.backgroundColor = gencolor
        signInRegisterButton.setTitleColor(.white, for: .normal)
        signInRegisterButton.addTarget(self, action: #selector(userSignInRegister), for: .touchUpInside)
        signInRegisterButton.titleLabel?.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        signInRegisterButton.titleLabel?.textAlignment = .center
        signInRegisterButton.layer.cornerRadius = 20
        signInRegisterButton.layer.borderWidth = 3
        signInRegisterButton.layer.borderColor = UIColor.white.cgColor
        signInRegisterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        applyShadow(button: signInRegisterButton, shadow: shadowcolor)
        view.addSubview(signInRegisterButton)
        
        bulb = UIImageView()
        bulb.image = UIImage(named: "bulb")
        view.addSubview(bulb)
        
        setup()
    }
    
    var hide: Constraint!
    var unhide: Constraint!
    var hidegap: Constraint!
    var unhidegap: Constraint!
    
    @objc func handle(){
        if sc.selectedSegmentIndex == 0 {
            signInRegisterButton.setTitle("Sign In", for: .normal)
            unhide.deactivate()
            hide.activate()
            unhidegap.deactivate()
            hidegap.activate()
        } else {
            signInRegisterButton.setTitle("Register", for: .normal)
            hide.deactivate()
            unhide.activate()
            hidegap.deactivate()
            unhidegap.activate()
        }
    }
    
    @objc func userSignInRegister(){
        guard let name = userText.text, let password = pwText.text, let email = emailText.text else{
            //MARK: TODO: invalid, handle empty etc
            print("invalid form")
            return
        }
        
        if sc.selectedSegmentIndex == 0 {
            //sign in
            Auth.auth().signIn(withEmail: email, password: password, completion:{
                (result, error) in
                if error != nil{
                    print(error!)//MARK: error
                    return
                }
                
                // save to user defaults
                let uid = Auth.auth().currentUser!.uid
                Database.database().reference().child("users").child(uid).observe(.value) { (snapshot) in

                    if let dict = snapshot.value as? [String: Any]{
                        let currentPlayer = Player.fromDatabase(object: dict)
                        let playerEncoded = try? PropertyListEncoder().encode(currentPlayer)

                        self.userDefaults.set(playerEncoded, forKey: "currentPlayer")
                        self.userDefaults.set(Date(), forKey: "lastUpdated")
                        
                        self.userDefaults.synchronize()
                    }
                }
                
                self.navigationController?.popViewController(animated: true)
            })
            
        }
        else {
            //create user
            Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
                if error != nil{
                    print(error!)//MARK: error
                    return
                }
                guard let uid = result?.user.uid else{
                    return
                }
                let ref = Database.database().reference(fromURL: "https://triviac-63843.firebaseio.com/")
                let usersRef = ref.child("users").child(uid)
                let values = Player.init(name: name, uid: uid, email: email, color: UIColor.randomColor().toHex(alpha: true)!).forDatabase()
                usersRef.updateChildValues(values) { (err, ref) in
                    if err != nil {
                        print(err!)
                        return
                    }
                }
            })
            //MARK: Some message
            sc.selectedSegmentIndex = 0
            signInRegisterButton.setTitle("Sign In", for: .normal)
            unhide.deactivate()
            hide.activate()
            unhidegap.deactivate()
            hidegap.activate()
        }
        
    }
    
    func setup(){
        sc.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY).offset(-50)
            make.width.equalTo(view.frame.width - 2*gap)
            make.height.equalTo(30)
        }
        
        userText.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            
            unhidegap = make.top.equalTo(sc.snp.bottom).offset(gap).constraint
            unhide = make.height.equalTo(50).constraint
            make.width.equalTo(view.frame.width - 2*gap)
        }
        unhide.deactivate()
        unhidegap.deactivate()
        userText.snp.makeConstraints{ make in
            hidegap = make.top.equalTo(sc.snp.bottom).constraint
            hide = make.height.equalTo(0).constraint
        }
        
        
        emailText.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(userText.snp.bottom).offset(gap)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width - 2*gap)
        }
        
        pwText.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(emailText.snp.bottom).offset(gap)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width - 2*gap)
        }
        
        signInRegisterButton.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(pwText.snp.bottom).offset(gap*2)
            make.width.equalTo(200)
        }
        signInRegisterButton.titleLabel?.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-3)
        }
        
        bulb.snp.makeConstraints{ make in
            make.bottom.equalTo(sc.snp.top).offset(-gap*3)
            make.height.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    }
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}
