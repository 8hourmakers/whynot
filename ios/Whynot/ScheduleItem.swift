//
// Created by Noverish Harold on 2017. 9. 3..
// Copyright (c) 2017 Noverish Harold. All rights reserved.
//

import UIKit

class ScheduleItem {
    var id: Int
    var date: Date
    var status: ScheduleItem.Status

    init(_ json: JSON) {
        id = json["id"].intValue
        date = GlobalDateFrmatter.date(from: json["datetime"].stringValue)!
        status = ScheduleItem.Status.extract(json["status"].stringValue)!
    }

    enum Status {
        case todo
        case complete

        static func extract(_ str: String) -> ScheduleItem.Status? {
            switch str {
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
