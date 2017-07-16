//
//  GlobalConfig.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 12..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation

class GlobalConfig {
    static let USER_DEFAULT_EMAIL = "email"
    static let USER_DEFAULT_PASSWORD = "password"
    
    static let SEGUE_AUTO_LOGIN = "segAutoLogin"
    static let SEGUE_LOGIN = "segLogin"
    static let SEGUE_LOGIN_SUCCESS = "segLoginSuccess"
    static let SEGUE_REGISTER_SUCCESS = "segRegisterSuccess"
    static let SEGUE_TODO_ADD = "segTodoAdd"
    
    static let SPLASH_DURATION: Double = 1 //second
    
    static let CALENDAR_START_DATE = Date(year: 1970, month: 1, day: 1)
    static let CALENDAR_END_DATE = Date(year: 2099, month: 12, day: 31)
}
