//
//  CalendarVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 11..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    @IBOutlet weak var calendar: JTAppleCalendarView!
    @IBOutlet weak var dateSelectBtn: UIView!
    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var dateMoveBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerHeight: NSLayoutConstraint!

    let datePickerHeightOrigin: CGFloat = 193

    var isDatePickerOpen = false
    
    override func viewDidLoad() {
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
        calendar.scrollDirection = .vertical
        calendar.scrollToDate(Date())
        calendar.visibleDates { visibleDates in
            self.setupDateLabels(visibleDates)
        }

        dateSelectBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dateSelectClicked)))

        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
    }
    
    func setupDateLabels(_ visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        yearMonthLabel.text = date.toString(format: "yyyy.MM")
    }

    //Interactions
    @IBAction func dateSelectClicked() {
        isDatePickerOpen = !isDatePickerOpen

        datePickerHeight.constant = isDatePickerOpen ? datePickerHeightOrigin : 0
        dateMoveBtn.isHidden = !isDatePickerOpen

        UIView.animate(withDuration: 0.4,
                       animations: {
                           self.view.layoutIfNeeded()
                       })
    }

    @IBAction func dateMoveClicked() {
        dateSelectClicked()
        calendar.selectDates([datePicker.date])
        calendar.scrollToDate(datePicker.date)
    }
    
    //DataSource
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: GlobalConfig.CALENDAR_START_DATE, endDate: GlobalConfig.CALENDAR_END_DATE)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: String(describing: CalendarCell.self), for: indexPath) as! CalendarCell
        
        cell.setState(cellState)
        
        return cell
    }
    
    //Delegates
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupDateLabels(visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if cellState.dateBelongsTo != .thisMonth {
            calendar.scrollToDate(date)
            return
        }
        
        guard let cell = cell as? CalendarCell else { return }
        cell.setState(cellState, shouldSelect: true)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        cell.setState(cellState, shouldDeselect: true)
    }
}
