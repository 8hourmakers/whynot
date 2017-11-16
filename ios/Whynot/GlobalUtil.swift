//
//  GlobalUtil.swift
//
//  For Swift 3.1
//  Created by Noverish Harold on 2017.5.28..
//  Copyright © 2017년 Noverish. All rights reserved.
//  https://gist.github.com/Noverish/f16c1c7e780e675bca7bc1e6079159d2
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
    func setShadow(radius:Int = 1,
                   color:UIColor = UIColor.black,
                   offset:CGSize = CGSize.zero,
                   opacity:Float = 0.5) {

        self.layer.shadowRadius = CGFloat(radius)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
    }

    func setBorder(width: CGFloat = 1,
                   color: UIColor = UIColor.black) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

    func setGradient(colors:[UIColor] = [UIColor.white, UIColor.black],
                     startPoint: CGPoint = CGPoint(0, 0),
                     endPoint: CGPoint = CGPoint(1, 1),
                     cornerRadius: CGFloat = 0) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        for subLayer in self.layer.sublayers ?? [] {
            if subLayer is CAGradientLayer {
                subLayer.removeFromSuperlayer()
            }
        }

        self.layer.addSublayer(gradientLayer)
    }

    func setRadius(_ radius: CGFloat = 0) {
        self.layer.cornerRadius = radius
    }

    func updateLayers() {
        self.layer.sublayers?.forEach {
            $0.frame = self.frame
        }
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
    }

    @IBAction func hideKeyboard() {
        self.view.endEditing(true)
    }

    @IBAction func dismissWithAnimation() {
        self.dismiss(animated: true)
    }

    @IBAction func dismissWithoutAnimation() {
        self.dismiss(animated: false)
    }

    func showAlertView(title: String,
                       msg: String,
                       preferredStyle: UIAlertControllerStyle = .alert,
                       actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: preferredStyle)

        for action in actions {
            alert.addAction(action)
        }

        self.present(alert, animated: true, completion: nil)
    }
}

//https://stackoverflow.com/a/43664156
extension Date {
    init(year: Int, month: Int, day: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        self.init(timeInterval: 0, since: formatter.date(from: "\(year)-\(month)-\(day)")!)
    }

    func isInSameDay(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }
    func isInSameWeek(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    func isInSameMonth(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    func isInSameYear(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    var isInThisWeek: Bool {
        return isInSameWeek(Date())
    }

    var day: Int {
        return Calendar.current.dateComponents([.day], from: self).day!
    }
    var month: Int {
        return Calendar.current.dateComponents([.month], from: self).month!
    }
    var year: Int {
        return Calendar.current.dateComponents([.year], from: self).year!
    }
    var monthStr: String {
        return monthStr(locale: Locale.current)
    }
    var dayOfWeek: String {
        return dayOfWeek(locale: Locale.current)
    }

    func monthStr(locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        return dateFormatter.monthSymbols[self.month - 1]
    }

    func dayOfWeek(locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }

    func toString(format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        return formatter.string(from: self)
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a:Int = 255) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }

    convenience init(argb: Int) {
        var alpha:Int = argb >> 24
        if alpha == 0 {
            alpha = 255
        }

        self.init(
                r: (argb >> 16) & 0xFF,
                g: (argb >> 8) & 0xFF,
                b: argb & 0xFF,
                a: alpha
        )
    }

    convenience init(rgbString: String) {
        let rgbString = rgbString.replacingOccurrences(of: "#", with: "")
        let rgb = Int(rgbString, radix:16)!

        self.init(argb: rgb)
    }

    convenience init(gray: Int) {
        self.init(
                r: gray,
                g: gray,
                b: gray
        )
    }
}

extension UIEdgeInsets {
    init(_ size: CGFloat) {
        self.init(top: size, left: size, bottom: size, right: size)
    }
}

extension CGPoint {
    init(_ x: Int, _ y: Int) {
        self.init(x: CGFloat(x), y: CGFloat(y))
    }
}

extension CGSize {
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
}

extension CGRect {
    mutating func changeHeight(_ height: CGFloat) {
        self.size = CGSize(self.width, height)
    }
}

extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}