//
//  SplashVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    var waitDone = false
    var autoLoginDone = false
    var loginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ServerClient.getCategories()

        DispatchQueue.main.asyncAfter(deadline: .now() + GlobalConfig.SPLASH_DURATION) {
            if self.autoLoginDone {
                self.process()
            } else {
                self.waitDone = true
            }
        }

        if let email = UserDefaults.standard.string(forKey: GlobalConfig.USER_DEFAULT_EMAIL),
           let password = UserDefaults.standard.string(forKey: GlobalConfig.USER_DEFAULT_PASSWORD) {
            
            ServerClient.login(email: email, password: password) { success in
                self.loginSuccess = success
                
                if self.waitDone {
                    self.process()
                } else {
                    self.autoLoginDone = true
                }
            }
        } else {
            self.autoLoginDone = true
        }
    }
    
    func process() {
        if loginSuccess {
            performSegue(withIdentifier: GlobalConfig.SEGUE_AUTO_LOGIN, sender: nil)
        } else {
            performSegue(withIdentifier: GlobalConfig.SEGUE_LOGIN, sender: nil)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
