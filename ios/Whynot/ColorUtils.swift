//
//  ColorUtils.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 11..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit
import Foundation

class ColorUtils {
    static let MAIN_COLOR = UIColor(rgb: 0x3FB4FB)
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a:Int = 255) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }
    
    convenience init(rgb: Int) {
        self.init(
            r: (rgb >> 16) & 0xFF,
            g: (rgb >> 8) & 0xFF,
            b: rgb & 0xFF
        )
    }
}
