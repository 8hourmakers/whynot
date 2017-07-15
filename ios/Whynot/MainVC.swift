//
//  MainVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 11..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var homeVC: HomeVC!
    @IBOutlet weak var homeVCContainer: UIView!
    @IBOutlet weak var homeTabBtn: UIButton!
    @IBOutlet weak var listVC: ListVC!
    @IBOutlet weak var listVCContainer: UIView!
    @IBOutlet weak var listTabBtn: UIButton!
    @IBOutlet weak var calendarVC: CalendarVC!
    @IBOutlet weak var calendarVCContainer: UIView!
    @IBOutlet weak var calendarTabBtn: UIButton!
    @IBOutlet weak var settingVC: SettingVC!
    @IBOutlet weak var settingVCContainer: UIView!
    @IBOutlet weak var settingTabBtn: UIButton!
    
    var nowTab = MainTab.home
    
    @IBAction func tabBtnClicked(_ sender: Any) {
        switch sender as! UIButton {
        case homeTabBtn:
            nowTab = .home
        case listTabBtn:
            nowTab = .list
        case calendarTabBtn:
            nowTab = .calendar
        case settingTabBtn:
            nowTab = .setting
        default:
            break
        }
        
        homeVCContainer.isHidden = (nowTab == .home) ? false : true
        listVCContainer.isHidden = (nowTab == .list) ? false : true
        calendarVCContainer.isHidden = (nowTab == .calendar) ? false : true
        settingVCContainer.isHidden = (nowTab == .setting) ? false : true
        
        homeTabBtn.setTitleColor((nowTab == .home) ? ColorUtils.MAIN_COLOR : UIColor.black, for: .normal)
        listTabBtn.setTitleColor((nowTab == .list) ? ColorUtils.MAIN_COLOR : UIColor.black, for: .normal)
        calendarTabBtn.setTitleColor((nowTab == .calendar) ? ColorUtils.MAIN_COLOR : UIColor.black, for: .normal)
        settingTabBtn.setImage((nowTab == .setting) ? UIImage(named:"btnMyOn") : UIImage(named:"btnMyOff"), for: .normal)
    }
    
    @IBAction func homeTabClicked() {
        nowTab = .home
    }
    
    @IBAction func listTabClicked() {
        nowTab = .list
    }
    
    @IBAction func calendarTabClicked() {
        nowTab = .calendar
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case is HomeVC:
            homeVC = segue.destination as! HomeVC
            break
        case is ListVC:
            listVC = segue.destination as! ListVC
            break
        case is CalendarVC:
            calendarVC = segue.destination as! CalendarVC
            break
        case is SettingVC:
            settingVC = segue.destination as! SettingVC
            break
        default:
            break
        }
    }
}

enum MainTab {
    case home
    case list
    case calendar
    case setting
}
