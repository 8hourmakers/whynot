//
//  ViewController.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var todoTableView:TodoTableView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let today = Date()
        dayLabel.text = String(today.day)
        monthLabel.text = today.monthStr(locale: Locale(identifier: "en_US"))
        yearLabel.text = String(today.year)
        dayOfWeekLabel.text = today.dayOfWeek(locale: Locale(identifier: "en_US"))
        
        todoTableView.initiate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addClicked() {
        performSegue(withIdentifier: GlobalConfig.SEGUE_TODO_ADD, sender: nil)
    }
}

