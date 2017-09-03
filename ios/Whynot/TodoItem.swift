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
    var category: CategoryItem

    var expanded: Bool = false //cell related property
    
    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        startDate = GlobalDateFrmatter.date(from: json["start_datetime"].stringValue)!
        endDate = GlobalDateFrmatter.date(from: json["end_datetime"].stringValue)!
        repeatDay = json["repeat_day"].intValue
        memo = json["memo"].stringValue
        alarmMinute = json["alarm_minutes"].intValue
        category = CategoryItem(json["category"])
        
        schedules = []
        for innerJson in json["schedules"].arrayValue {
            schedules.append(ScheduleItem(innerJson))
        }
    }
}

class CategoryItem {
    var id: Int
    var name: String
    var imgUrl: String
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        imgUrl = json["image"].stringValue
    }
    
    var icon:UIImage {
        get {
            switch id {
            case 1:
                return UIImage(named: "categoryBeautyOff")!
            case 3:
                return UIImage(named: "categoryFinanceOff")!
            case 4:
                return UIImage(named: "categoryFriendOff")!
            case 5:
                return UIImage(named: "categoryExersizeOff")!
            case 6:
                return UIImage(named: "categoryStudyOff")!
            case 7:
                return UIImage(named: "categoryHealthOff")!
            case 8:
                return UIImage(named: "categoryLivingOff")!
            case 9:
                return UIImage(named: "categoryEtcOff")!
            default:
                return UIImage(named: "categoryEtcOff")!
            }
        }
    }
}

