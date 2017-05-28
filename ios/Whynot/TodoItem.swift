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
    var category: TodoCategory
    
    init(id: Int,
         title: String,
         startDate: Date,
         endDate: Date,
         repeatDay: Int,
         schedules: [TodoScheduleItem],
         memo: String,
         alarmMinute: Int,
         category: TodoCategory) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.repeatDay = repeatDay
        self.schedules = schedules
        self.memo = memo
        self.alarmMinute = alarmMinute
        self.category = category
    }
    
    static func extract(_ json: JSON) -> TodoItem {
        let id = json["id"].intValue
        let title = json["title"].stringValue
        let startDate = GlobalDateFrmatter.date(from: json["start_datetime"].stringValue)!
        let endDate = GlobalDateFrmatter.date(from: json["end_datetime"].stringValue)!
        let repeatDay = json["repeat_day"].intValue
        let memo = json["memo"].stringValue
        let alarmMinute = json["alarm_minutes"].intValue
        let category = TodoCategory.extract(json["category"])
        
        var schedules:[TodoScheduleItem] = []
        for innerJson in json["schedules"].arrayValue {
            schedules.append(TodoScheduleItem.extract(innerJson))
        }
        
        return TodoItem(
            id: id,
            title: title,
            startDate: startDate,
            endDate: endDate,
            repeatDay: repeatDay,
            schedules: schedules,
            memo: memo,
            alarmMinute: alarmMinute,
            category: category
        )
    }
}

class TodoCategory {
    var id: Int
    var name: String
    var imgUrl: String
    
    init(id: Int,
         name: String,
         imgUrl: String) {
        self.id = id
        self.name = name
        self.imgUrl = imgUrl
    }
    
    static func extract(_ json: JSON) -> TodoCategory {
        let id = json["id"].intValue
        let name = json["name"].stringValue
        let imgUrl = json["image"].stringValue
        
        return TodoCategory(
            id: id,
            name: name,
            imgUrl: imgUrl
        )
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

