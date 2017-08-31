//
//  TodoTableView.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation
import UIKit

class TodoTableView: InfiniteTableView, InfiniteTableViewDelegate, InfiniteTableViewDataSource {

    func initiate() {
        super.delegate = self
        super.collectionViewFlowLayout.minimumLineSpacing = CGFloat(16)
        super.initiate(nibName: String(describing: ScheduleCell.self), dataSource: self)
    }

    func infiniteTableView(_ infiniteTableView: InfiniteTableView, set cell: UICollectionViewCell, for item: Any) -> UICollectionViewCell {
        if let cell = cell as? ScheduleCell {
            if let item = item as? TodoItem {
                cell.setItem(item)
            }
        }

        return cell
    }

    func infiniteTableView(_ infiniteTableView: InfiniteTableView, itemsOn page: Int, callback: @escaping ([Any]) -> Void) {
        if(page > 1) {
            callback([Any]())
            return
        }

        ServerClient.getSchedules() { (schedules) in
            callback(schedules)
        }
    }

}
