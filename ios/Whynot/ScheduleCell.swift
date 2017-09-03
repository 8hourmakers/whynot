//
//  ScheduleCell.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    static let color1 = UIColor(red:63/255, green:180/255, blue:251/255, alpha:1)
    static let color2 = UIColor(red:131/255, green:209/255, blue:221/255, alpha:1)
    static let shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.3)
    
    @IBOutlet weak var root:UIView!
    @IBOutlet weak var bg:UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var check: UIImageView!

    var item: TodoItem?

    override func awakeFromNib() {
        DispatchQueue.main.async {
            self.bg.setShadow(radius: 5, offset: CGSize(2, 2), opacity: 0.2)
        }
    }
    
    func setItem(_ item: TodoItem) {
        self.item = item

        let isAllDone = item.schedules.reduce(true) { $0 && ($1.status == .complete) }
        if isAllDone {
            drawAsComplete(item)
        } else {
            drawAsTodo(item)
        }
    }

    private func drawAsComplete(_ item: TodoItem) {
        bg.setGradient(colors: [UIColor.white, UIColor.white], cornerRadius: 25)
        check.isHidden = false

        let textColor = UIColor(r: 197, g:197, b: 197)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.title)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: NSMakeRange(0, attributeString.length))
        title.attributedText = attributeString
    }
    
    private func drawAsTodo(_ item: TodoItem) {
        bg.setGradient(colors: [ScheduleCell.color1, ScheduleCell.color2], cornerRadius: 25)
        check.isHidden = true
        title.text = item.title
    }

    public func doneSchedule() {
        guard let item = item else {
            return
        }

        for schedule in item.schedules {
            schedule.status = .complete
            ServerClient.completeSchedule(scheduleId: schedule.id)
        }

        DispatchQueue.main.async {
            self.drawAsComplete(item)
        }
    }
}
