//
//  Values.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 16..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let mainColor = UIColor(argb: 0x3FB4FB)
}

extension UIFont {
    static let nanumBold = UIFont (name: "NanumBarunGothicOTFBold", size: 10)!
    static let nanumNormal = UIFont (name: "NanumBarunGothicOTF", size: 10)!
    static let nanumLight = UIFont (name: "NanumBarunGothicOTFLight", size: 10)!
    static let nanumUltraLight = UIFont (name: "NanumBarunGothicOTFUltraLight", size: 10)!
}

class CustomGradientView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setGradient(colors: [ScheduleCell.color1, ScheduleCell.color2])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setGradient(colors: [ScheduleCell.color1, ScheduleCell.color2])
    }
}
