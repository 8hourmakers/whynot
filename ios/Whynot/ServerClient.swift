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
    static var categories:[CategoryItem] = []
    
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
    
    /*
    static func getMyTodo(keyword: String,
                          category: Int,
                          callback: @escaping ([TodoItem]) -> Void) {
        let uri = "/todos/self/"
        let json = JSON([
            "search":keyword,
            "category_id":category
        ])
        
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
    */
    
    static func getSchedules(callback: @escaping ([TodoItem]) -> Void) {
        let uri = "/todos/schedules/"
        let json = JSON([:])
        
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
                         category: CategoryItem,
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
    
    static func getCategories(callback: (([CategoryItem]) -> Void)? = nil) {
        let uri = "/categories/"
        let json = JSON([:])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .get) { (res, json) in
            if !res.isSuccess() {
                return
            }
            
            self.categories.removeAll()
            for innerJson in json.arrayValue {
                self.categories.append(CategoryItem(innerJson))
            }
            
            callback?(self.categories)
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
            
            let res = String(data:data!, encoding:String.Encoding.utf8)!
            print("<HTTP> \(url) : \(json.rawValue) -> \(res)\n\n")
            
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
