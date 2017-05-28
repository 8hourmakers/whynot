//
//  Util.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation

extension String {
    @discardableResult
    mutating func removeLastChar() -> String{
        self = self.substring(to: self.index(before: self.endIndex))
        return self
    }
}
