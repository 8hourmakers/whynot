//
//  Util.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation
import UIKit

extension String {
    @discardableResult
    mutating func removeLastChar() -> String {
        self = self.substring(to: self.index(before: self.endIndex))
        return self
    }
}

extension HTTPURLResponse {
    func isSuccess() -> Bool {
        return (200 ... 299).contains(self.statusCode)
    }
}

extension UIView {
    func addShadow(radius:Int = 1,
                   color:UIColor = UIColor.black,
                   offset:CGSize = CGSize.zero,
                   opacity:Float = 0.5) {
        
        self.layer.shadowRadius = CGFloat(radius)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.3).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
    }
    
    func addBorder(width: CGFloat = 1,
                   color: UIColor = UIColor.black) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}

extension UIViewController {
    func showToast(_ message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
