//
//  RegisterVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var userNameField:UITextField!
    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerClicked() {
        let userName = userNameField.text!
        let emailLabel = emailField.text!
        let passwordLabel = passwordField.text!
        
        ServerClient.register(userName: userName, email: emailLabel, password: passwordLabel) { (success) in
            DispatchQueue.main.async {
                if success {
                    
                } else {
                    
                }
            }
        }
    }
    
    @IBAction func backClicked() {
        self.dismiss(animated: true)
    }

}
