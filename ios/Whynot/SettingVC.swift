//
//  HomeVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class SettingVC: BaseVC {
    
    @IBOutlet weak var announce: UIView!
    @IBOutlet weak var login: UIView!
    @IBOutlet weak var loginEmail: UILabel!
    @IBOutlet weak var customer: UIView!
    @IBOutlet weak var password: UIView!
    @IBOutlet weak var calendar: UIView!
    @IBOutlet weak var clause: UIView!
    @IBOutlet weak var info: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginEmail.text = UserDefaults.standard.string(forKey: GlobalConfig.USER_DEFAULT_EMAIL)
        
        login.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.logoutClicked)))
    }
    
    func logoutClicked() {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "예", style: UIAlertActionStyle.default, handler:  { action in
            UserDefaults.standard.removeObject(forKey: GlobalConfig.USER_DEFAULT_EMAIL)
            UserDefaults.standard.removeObject(forKey: GlobalConfig.USER_DEFAULT_PASSWORD)
            
            let vc = self.presentingViewController
            self.dismiss(animated: true) {
                if let vc = vc as? SplashVC {
                    vc.performSegue(withIdentifier: GlobalConfig.SEGUE_LOGIN, sender: nil)
                }
                if let vc = vc as? RegisterVC {
                    vc.dismiss(animated: true)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "아니오", style: UIAlertActionStyle.cancel, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
