//
//  TodoItem.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation

class TodoItem {
    var id: Int
    var title: String
    var startDate: Date
    var endDate: Date
    var repeatDay: Int
    var schedules: [TodoScheduleItem]
    var memo: String
    var alarmMinute: Int
    var category: TodoCategoryItem
    
    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        startDate = GlobalDateFrmatter.date(from: json["start_datetime"].stringValue)!
        endDate = GlobalDateFrmatter.date(from: json["end_datetime"].stringValue)!
        repeatDay = json["repeat_day"].intValue
        memo = json["memo"].stringValue
        alarmMinute = json["alarm_minutes"].intValue
        category = TodoCategoryItem(json["category"])
        
        schedules = []
        for innerJson in json["schedules"].arrayValue {
            schedules.append(TodoScheduleItem.extract(innerJson))
        }
    }
}

class TodoCategoryItem {
    var id: Int
    var name: String
    var imgUrl: String
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        imgUrl = json["image"].stringValue
    }
}

class TodoScheduleItem {
    var id: Int
    var date: Date
    var status: TodoScheduleItem.Status
    
    init(id: Int,
         date: Date,
         status: TodoScheduleItem.Status) {
        self.id = id
        self.date = date
        self.status = status
    }
    
    static func extract(_ json: JSON) -> TodoScheduleItem {
        let id = json["id"].intValue
        let date = GlobalDateFrmatter.date(from: json["datetime"].stringValue)!
        let status = TodoScheduleItem.Status.extract(json["status"].stringValue)!
        
        return TodoScheduleItem(
            id: id,
            date: date,
            status: status
        )
    }
    
    enum Status {
        case uncomplete
        case todo
        case complete
        
        static func extract(_ str: String) -> TodoScheduleItem.Status? {
            switch str {
            case "UNCOMPLETE":
                return .uncomplete
            case "TODO":
                return .todo
            case "COMPLETE":
                return .complete
            default:
                return nil
            }
        }
    }
}

