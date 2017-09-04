//
// Created by Noverish Harold on 2017. 9. 4..
// Copyright (c) 2017 Noverish Harold. All rights reserved.
//

import UIKit

class CategoryItem: Equatable{
    var id: Int
    var name: String
    var imgUrl: String

    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        imgUrl = json["image"].stringValue
    }

    public static func ==(lhs: CategoryItem, rhs: CategoryItem) -> Bool {
        return lhs.id == rhs.id
    }
}

enum Category {
    case beauty
    case finance
    case friend
    case exercise
    case study
    case health
    case living
    case etc

    static var categoryItems:[CategoryItem] = []

    public static func parse(from id: Int) -> Category? {
        for e in iterateEnum(Category.self) {
            if(e.id == id) {
                return e
            }
        }

        return nil
    }

    var id: Int {
        switch self {
        case .beauty: return 1
        case .finance: return 3
        case .friend: return 4
        case .exercise: return 5
        case .study: return 6
        case .health: return 7
        case .living: return 8
        case .etc: return 9
        }
    }

    var icon:UIImage {
        get {
            switch self {
            case .beauty: return UIImage(named: "categoryBeautyOff")!
            case .finance: return UIImage(named: "categoryFinanceOff")!
            case .friend: return UIImage(named: "categoryFriendOff")!
            case .exercise: return UIImage(named: "categoryExersizeOff")!
            case .study: return UIImage(named: "categoryStudyOff")!
            case .health: return UIImage(named: "categoryHealthOff")!
            case .living: return UIImage(named: "categoryLivingOff")!
            case .etc: return UIImage(named: "categoryEtcOff")!
            }
        }
    }

    var onImage:UIImage {
        get {
            switch self {
            case .beauty: return UIImage(named: "categoryBeautyOn")!
            case .finance: return UIImage(named: "categoryFinanceOn")!
            case .friend: return UIImage(named: "categoryFriendOn")!
            case .exercise: return UIImage(named: "categoryExersizeOn")!
            case .study: return UIImage(named: "categoryStudyOn")!
            case .health: return UIImage(named: "categoryHealthOn")!
            case .living: return UIImage(named: "categoryLivingOn")!
            case .etc: return UIImage(named: "categoryEtcOn")!
            }
        }
    }

    var offImage:UIImage {
        get {
            switch self {
            case .beauty: return UIImage(named: "categoryBeautyOff")!
            case .finance: return UIImage(named: "categoryFinanceOff")!
            case .friend: return UIImage(named: "categoryFriendOff")!
            case .exercise: return UIImage(named: "categoryExersizeOff")!
            case .study: return UIImage(named: "categoryStudyOff")!
            case .health: return UIImage(named: "categoryHealthOff")!
            case .living: return UIImage(named: "categoryLivingOff")!
            case .etc: return UIImage(named: "categoryEtcOff")!
            }
        }
    }

    var item: CategoryItem {
        return Category.categoryItems.filter({ $0.id == self.id }).first!
    }
}

