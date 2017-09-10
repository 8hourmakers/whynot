//
// Created by Noverish Harold on 2017. 9. 10..
// Copyright (c) 2017 Noverish Harold. All rights reserved.
//

import Foundation

class CalendarTodoTableView: TodoTableView {
    var date: Date?

    override func infiniteTableView(_ infiniteTableView: InfiniteTableView, itemsOn page: Int, callback: @escaping ([Any]) -> Void) {
        if(page > 1) {
            callback([Any]())
            return
        }

        ServerClient.getSchedules(date: date) { (todos) in
            callback(todos)
        }
    }
}
