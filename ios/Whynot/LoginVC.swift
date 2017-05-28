//
//  LoginVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        
        ServerClient.login(email: email, password: password) { (success) in
            DispatchQueue.main.async {
                if success {
                    self.backClicked()
                } else {
                    
                }
            }
        }
    }

}
