//
//  HomeVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
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

        announce.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.announceClicked)))
        login.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.loginInfoClicked)))
        customer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.customerClicked)))
        password.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.passwordClicked)))
        calendar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.calendarClicked)))
        clause.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clauseClicked)))
        info.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.programInfoClicked)))
    }

    @objc private func announceClicked() {
        self.showNotReadyAlert()
    }

    @objc private func loginInfoClicked() {
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

    @objc private func customerClicked() {
        self.showNotReadyAlert()
    }

    @objc private func passwordClicked() {
        self.showNotReadyAlert()
    }

    @objc private func calendarClicked() {
        self.showNotReadyAlert()
    }

    @objc private func clauseClicked() {
        self.showNotReadyAlert()
    }

    @objc private func programInfoClicked() {
        self.showNotReadyAlert()
    }

    @objc private func showNotReadyAlert() {
        self.showAlertView(
                title: "준비중",
                msg: "준비중입니다.",
                preferredStyle: .alert,
                actions: [ UIAlertAction(title: "확인", style: .default) ]
        )
    }
}
