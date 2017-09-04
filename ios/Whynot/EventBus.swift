//
//  EventBus.swift
//
//  Created by Noverish Harold on 2017. 5. 30..
//  Copyright © 2017년 Noverish. All rights reserved.
//  https://gist.github.com/Noverish/d1e63955a1ff8579be9308d28024d057
//

import Foundation

class EventBus {
    static func register(_ observer: Any, event:Event, action: Selector) {
        NotificationCenter.default.addObserver(observer, selector: action, name: Notification.Name(rawValue: event.rawValue), object: nil)
    }

    static func post(event: Event, data: Any? = nil) {
        NotificationCenter.default.post(name: Notification.Name(event.rawValue), object: data)
    }

    enum Event:String {
        case scheduleClicked = "scheduleClicked"
        case todoCellModifyClicked = "todoCellModifyClicked"
        case todoCellDeleteClicked = "todoDeleteClicked"
        case todoCellExpanded = "todoCellExpanded"
        case todoListLoaded = "todoListLoaded"
        case todoAdded = "todoAdded"
        case todoModified = "todoModified"
    }
}