//
//  TodoItem.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class TodoItem {
    var id: Int
    var title: String
    var startDate: Date
    var endDate: Date
    var repeatDay: Int
    var schedules: [ScheduleItem]
    var memo: String
    var alarmMinute: Int
    var category: Category

    var expanded: Bool = false //cell related property
    
    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        startDate = GlobalDateFrmatter.date(from: json["start_datetime"].stringValue)!
        endDate = GlobalDateFrmatter.date(from: json["end_datetime"].stringValue)!
        repeatDay = json["repeat_day"].intValue
        memo = json["memo"].stringValue
        alarmMinute = json["alarm_minutes"].intValue
        category = Category.parse(from: json["category"]["id"].intValue)!
        
        schedules = []
        for innerJson in json["schedules"].arrayValue {
            schedules.append(ScheduleItem(innerJson))
        }
    }
}