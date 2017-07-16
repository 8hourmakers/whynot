//
//  LoginVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class LoginVC: BaseVC, UITextFieldDelegate {

    @IBOutlet weak var closeBtn: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.setBorder(color: UIColor.white)
        closeBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backClicked)))
        
        //hide keyboard when screent tapped
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        //added return button clicked listener
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func loginClicked() {
        let email = emailField.text!
        let password = passwordField.text!
        
        ServerClient.login(email: email, password: password) { (success) in
            DispatchQueue.main.async {
                if success {
                    self.performSegue(withIdentifier: GlobalConfig.SEGUE_LOGIN_SUCCESS, sender: nil)
                } else {
                    self.showToast("로그인에 실패했습니다")
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
            break
        default:
            hideKeyboard()
            loginClicked()
        }
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
