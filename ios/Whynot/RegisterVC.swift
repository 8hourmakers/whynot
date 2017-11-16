//
//  RegisterVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollViewBottom: NSLayoutConstraint!
    @IBOutlet weak var closeBtn: UIView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerBtn.setBorder(color: UIColor.white)
        closeBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissWithAnimation)))
        
        //hide keyboard when screent tapped
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //added return button clicked listener
        emailField.delegate = self
        passwordField.delegate = self
        userNameField.delegate = self
    }
    
    @IBAction func registerClicked() {
        let userName = userNameField.text!
        let emailLabel = emailField.text!
        let passwordLabel = passwordField.text!
        
        ServerClient.register(userName: userName, email: emailLabel, password: passwordLabel) { (success) in
            DispatchQueue.main.async {
                if success {
                    self.performSegue(withIdentifier: GlobalConfig.SEGUE_REGISTER_SUCCESS, sender: nil)
                } else {
                    self.showToast("회원 가입에 실패했습니다")
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            userNameField.becomeFirstResponder()
            break
        default:
            hideKeyboard()
            registerClicked()
        }
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollViewBottom.constant += keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
            self.scrollViewBottom.constant = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
