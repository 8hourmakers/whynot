//
//  ViewController.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var todoTableView: ScheduleTableView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let today = Date()
        dayLabel.text = String(today.day)
        monthLabel.text = today.monthStr(locale: Locale(identifier: "en_US"))
        yearLabel.text = String(today.year)
        dayOfWeekLabel.text = today.dayOfWeek(locale: Locale(identifier: "en_US"))

        gradientView.setGradient(
                colors: [UIColor(r: 255, g: 255, b: 255, a: 0), UIColor.white],
                startPoint: CGPoint(0, 0),
                endPoint: CGPoint(0, 1)
        )
        todoTableView.initiate()

        EventBus.register(self, event: .scheduleClicked, action: #selector(scheduleClicked))
    }

    func scheduleClicked(_ notification: Notification) {
        guard let cell:ScheduleCell = notification.object as? ScheduleCell else {
            return
        }

        showAlertView(
                title: "스케쥴 완료",
                msg: "이 스케쥴을 완료하셨습니까?",
                preferredStyle: .alert,
                actions: [
                        UIAlertAction(title: "예", style: .default, handler: { action in cell.doneSchedule() }),
                        UIAlertAction(title: "아니오", style: .cancel, handler: nil)
                ]
        )
    }

    @IBAction func addClicked() {
        performSegue(withIdentifier: GlobalConfig.SEGUE_TODO_ADD, sender: nil)
    }
}

