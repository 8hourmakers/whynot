//
//  ScheduleTableView.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation
import UIKit

class ScheduleTableView: InfiniteTableView, InfiniteTableViewDelegate, InfiniteTableViewDataSource {

    func initiate() {
        super.delegate = self
        super.collectionViewFlowLayout.minimumLineSpacing = CGFloat(0)
        super.collectionView.showsVerticalScrollIndicator = false
        super.initiate(nibName: String(describing: ScheduleCell.self), dataSource: self)
        
        EventBus.register(self, event: .todoAdded, action: #selector(self.todoAdded))
        EventBus.register(self, event: .todoModified, action: #selector(self.todoModified))
    }
    
    @objc private func todoAdded(_ notification: Notification) {
        refresh()
    }
    
    @objc private func todoModified(_ notification: Notification) {
        refresh()
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

    @objc func infiniteTableView(_ infiniteTableView: InfiniteTableView, didSelectItemAt indexPath: IndexPath, item: Any, cell: UICollectionViewCell) {
        guard let item = item as? TodoItem,
              let schedule = item.schedules.first else {
            return
        }

        if(schedule.status != .complete) {
            EventBus.post(event: .scheduleClicked, data: cell)
        }
    }

    func infiniteTableView(_ infiniteTableView: InfiniteTableView, item lhs: Any, isEqualTo rhs: Any) -> Bool {
        guard let lhs = lhs as? TodoItem,
              let rhs = rhs as? TodoItem else {
            return false
        }

        return lhs.id == rhs.id
    }

}
