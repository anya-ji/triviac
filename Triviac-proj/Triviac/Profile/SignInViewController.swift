//
//  SignInViewController.swift
//  Triviac
//
//  Created by Anya Ji on 6/7/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    let gencolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    let btcolor = UIColor(red: 0.77, green: 0.76, blue: 0.78, alpha: 1.00)
    let textcolor = UIColor.white
    let bordercolor = UIColor.white
    let shadowcolor = UIColor(red: 0.15, green: 0.16, blue: 0.16, alpha: 1.00)
    
    let gap: CGFloat = 20
    
    var sc: UISegmentedControl!
    var user: UITextField!
    var pw: UITextField!
    var email: UITextField!
    var signInRegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
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
        
        user = UITextField()
        user.backgroundColor = .white
        user.placeholder = "Username"
        user.textColor = .black
        user.borderStyle = UITextField.BorderStyle.roundedRect
        user.textAlignment = .left
        user.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        view.addSubview(user)
        
        pw = UITextField()
        pw.backgroundColor = .white
        pw.placeholder = "Password"
        pw.textColor = .black
        pw.borderStyle = UITextField.BorderStyle.roundedRect
        pw.textAlignment = .left
        pw.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        pw.isSecureTextEntry = true
        view.addSubview(pw)
        
        email = UITextField()
        email.backgroundColor = .white
        email.placeholder = "Email Address"
        email.textColor = .black
        email.borderStyle = UITextField.BorderStyle.roundedRect
        email.textAlignment = .left
        email.font = UIFont.init(name: "ChalkboardSE-Regular", size: 20)
        view.addSubview(email)
        
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
        
    }
    
    func setup(){
        sc.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY).offset(-50)
            make.width.equalTo(view.frame.width - 2*gap)
            make.height.equalTo(30)
        }
        
        user.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            
            unhidegap = make.top.equalTo(sc.snp.bottom).offset(gap).constraint
            unhide = make.height.equalTo(50).constraint
            make.width.equalTo(view.frame.width - 2*gap)
        }
        unhide.deactivate()
        unhidegap.deactivate()
        user.snp.makeConstraints{ make in
            hidegap = make.top.equalTo(sc.snp.bottom).constraint
            hide = make.height.equalTo(0).constraint
        }
        
        
        email.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(user.snp.bottom).offset(gap)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width - 2*gap)
        }
        
        pw.snp.makeConstraints{ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(email.snp.bottom).offset(gap)
            make.height.equalTo(50)
            make.width.equalTo(view.frame.width - 2*gap)
        }
        
        signInRegisterButton.snp.makeConstraints{ make in
                make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(pw.snp.bottom).offset(gap*2)
                make.width.equalTo(200)
            }
            signInRegisterButton.titleLabel?.snp.makeConstraints{ make in
                make.centerY.equalToSuperview().offset(-3)
            }
        
    }
    
    
}

