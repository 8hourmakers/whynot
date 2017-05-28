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
        let json = JSON([
            "username":userName,
            "email":email,
            "password":password
        ])
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .post) { (code, json) in
            switch code {
            case 200 ... 299:
                self.token = json["token"].stringValue
                callback(true)
                break
            default:
                callback(false)
                break
            }
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
        
        HttpUtil.connect(url: HOST+uri, json: json, httpMethod: .post) { (code, json) in
            switch code {
            case 200 ... 299:
                self.token = json["token"].stringValue
                callback(true)
                break
            default:
                callback(false)
                break
            }
        }
    }
}

class HttpUtil {
    
    static func connect(url:String, json:JSON, httpMethod:HTTPMethod = .post, callback: @escaping (Int, JSON) -> Void) {
        var url = url
        if httpMethod == HTTPMethod.get {
            url += "?"
            for (key, subJson):(String, JSON) in json {
                url += key + "=" + (subJson.rawValue as! String) + "&"
            }
            url.removeLastChar()
        }
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        if httpMethod != .get {
            request.httpBody = json.rawValue as? Data
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let response: HTTPURLResponse = response as? HTTPURLResponse, error == nil else {
                print(url + " - " + String(describing: error))
                return
            }
            
            let res = String(data:data!, encoding:String.Encoding.utf8)!
            print("<HTTP> \(url) : \(json.rawValue) -> \(res)\n\n")
            
            callback(response.statusCode, JSON(data!))
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
