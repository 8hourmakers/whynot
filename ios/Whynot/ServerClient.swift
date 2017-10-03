//
//  ServerClient.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation

class ServerClient {
    static let HOST = "http://8hourmakers.com/whynot/api"
    
    static var token = ""
    
    static func register(userName: String,
                         email: String,
                         password: String,
                         callback: @escaping (Bool) -> Void) {
        
        let uri = "/users/"
        let json:JSON = [
            "username":userName,
            "email":email,
            "password":password
        ]
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .post) { (res, json) in
            if !res.isSuccess() {
                callback(false)
                return
            }
            
            UserDefaults.standard.set(email, forKey: GlobalConfig.USER_DEFAULT_EMAIL)
            UserDefaults.standard.set(password, forKey: GlobalConfig.USER_DEFAULT_PASSWORD)
            self.token = json["token"].stringValue
            callback(true)
        }
    }
    
    static func login(email: String,
                      password: String,
                      callback: @escaping (Bool) -> Void) {
        let uri = "/users/auth/"
        let json = JSON([
            "email":email,
            "password":password
        ])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .post) { (res, json) in
            if !res.isSuccess() {
                callback(false)
                return
            }
            
            UserDefaults.standard.set(email, forKey: GlobalConfig.USER_DEFAULT_EMAIL)
            UserDefaults.standard.set(password, forKey: GlobalConfig.USER_DEFAULT_PASSWORD)
            self.token = json["token"].stringValue
            callback(true)
        }
    }
    
    static func logout(callback: @escaping (Bool) -> Void) {
        let uri = "/users/auth/"
        let json = JSON([:])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .delete) { (res, json) in
            if !res.isSuccess() {
                callback(false)
                return
            }
            
            self.token = ""
            callback(true)
        }
    }
    
    
    static func getMyTodo(keyword: String? = nil,
                          category: Int? = nil,
                          callback: @escaping ([TodoItem]) -> Void) {
        let uri = "/todos/"
        var json = JSON([:])
        
        if let keyword = keyword {
            json["query"].string = keyword
        }
        
        if let category = category {
            json["category_id"].int = category
        }
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .get) { (res, json) in
            if !res.isSuccess() {
                return
            }
            
            var items:[TodoItem] = []
            
            for innerJson in json.arrayValue {
                items.append(TodoItem(innerJson))
            }
            
            callback(items)
        }
    }
    
    static func getSchedules(date: Date? = nil,
                             callback: @escaping ([TodoItem]) -> Void) {
        let uri = "/todos/schedules/"
        var json = JSON([:])

        if let date = date {
            json["date"].string = date.toString(format: "yyyy-MM-dd")
        }
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .get) { (res, json) in
            if !res.isSuccess() {
                return
            }
            
            var items:[TodoItem] = []
            
            for innerJson in json.arrayValue {
                items.append(TodoItem(innerJson))
            }
            
            callback(items)
        }
    }

    static func completeSchedule(scheduleId: Int, callback: (() -> Void)? = nil) {
        let uri = "/todos/schedules/\(scheduleId)/done/"
        let json = JSON([:])

        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .post) { (res, json) in
            callback?()
        }
    }
    
    static func getRcmdTodo(categoryId: Int,
                            callback: @escaping ([TodoItem]) -> Void) {
        let uri = "/todo/recommend/"
        let json = JSON(["category_id":categoryId])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .get) { (res, json) in
            if !res.isSuccess() {
                return
            }
            
            var items:[TodoItem] = []
            
            for innerJson in json.arrayValue {
                items.append(TodoItem(innerJson))
            }
            
            callback(items)
        }
    }
    
    static func makeTodo(title: String,
                         category: Category,
                         startDate: Date,
                         endDate: Date,
                         repeatDay: Int,
                         memo: String,
                         alarmMinute: Int,
                         callback: @escaping (TodoItem) -> Void) {
        let uri = "/todos/"
        let json = JSON([
            "title": title,
            "category_id": category.id,
            "start_datetime": GlobalDateFrmatter.string(from: startDate),
            "end_datetime": GlobalDateFrmatter.string(from: endDate),
            "repeat_day": repeatDay,
            "memo": memo,
            "alarm_minutes": alarmMinute
        ])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .post) { (res, json) in
            if !res.isSuccess() {
                return
            }
            
            callback(TodoItem(json))
        }
    }
    
    static func modifyTodo(id: Int,
                           title: String,
                           category: Category,
                           startDate: Date,
                           endDate: Date,
                           repeatDay: Int,
                           callback: ((TodoItem) -> Void)? = nil) {
        let uri = "/todos/\(id)/"
        let json = JSON([
            "title": title,
            "category_id": category.id,
            "start_datetime": GlobalDateFrmatter.string(from: startDate),
            "end_datetime": GlobalDateFrmatter.string(from: endDate),
            "repeat_day": repeatDay
        ])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .put) { (res, json) in
            if !res.isSuccess() {
                return
            }
            
            callback?(TodoItem(json))
        }
    }
    
    static func deleteTodo(todoId: Int, callback: (() -> Void)? = nil) {
        let uri = "/todos/\(todoId)/"
        let json = JSON([:])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .delete) { (res, json) in
            if !res.isSuccess() {
                return
            }
            
            callback?()
        }
    }
    
    static func getCategories(callback: (([CategoryItem]) -> Void)? = nil) {
        let uri = "/categories/"
        let json = JSON([:])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .get) { (res, json) in
            if !res.isSuccess() {
                return
            }

            Category.categoryItems.removeAll()
            for innerJson in json.arrayValue {
                Category.categoryItems.append(CategoryItem(innerJson))
            }
            
            callback?(Category.categoryItems)
        }
    }
}

class HttpUtil {
    
    static func connect(url:String, json:JSON, httpMethod:HTTPMethod = .post, callback: @escaping (HTTPURLResponse, JSON) -> Void) {
        var url = url
        if httpMethod == HTTPMethod.get {
            url += "?"
            for (key, subJson):(String, JSON) in json {
                url += "\(key)=\(subJson.rawValue)&"
            }
            url.removeLastChar()
        }
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if ServerClient.token != "" {
            request.addValue("token \(ServerClient.token)", forHTTPHeaderField: "Authorization")
        }
        
        if httpMethod != .get {
            request.httpBody = String(describing: json).data(using: String.Encoding.utf8);
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let response: HTTPURLResponse = response as? HTTPURLResponse, error == nil else {
                print(url + " - " + String(describing: error))
                return
            }
            
//            let res = String(data:data!, encoding:String.Encoding.utf8)!
            print("<HTTP> \(httpMethod) : \(url) - \(json.rawValue)\n")
            
            callback(response, JSON(data!))
        }
        task.resume()
    }
}

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
