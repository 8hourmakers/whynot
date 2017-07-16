//
//  CalendarCell.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 15..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectMark: UIView!
    @IBOutlet weak var todayMark: UIView!
    
    func setState(_ state: CellState, shouldSelect: Bool = false, shouldDeselect: Bool = false) {
        dateLabel.text = state.text

        if state.dateBelongsTo != .thisMonth {
            todayMark.isHidden = true
            selectMark.isHidden = true
            dateLabel.textColor = UIColor.clear
            return
        }
        
        if (state.isSelected || shouldSelect) && !shouldDeselect {
            todayMark.isHidden = true
            selectMark.isHidden = false
            dateLabel.textColor = UIColor.white
            return
        }
        
        if state.date.isInToday {
            todayMark.isHidden = false
            selectMark.isHidden = true
            dateLabel.textColor = UIColor.white
            return
        }

        todayMark.isHidden = true
        selectMark.isHidden = true
        dateLabel.textColor = state.date.isWeekend ? UIColor(gray: 170) : UIColor.black
    }
}
