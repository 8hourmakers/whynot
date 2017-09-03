//
// Created by Noverish Harold on 2017. 9. 3..
// Copyright (c) 2017 Noverish Harold. All rights reserved.
//

import UIKit

class TodoTableView: InfiniteTableView, InfiniteTableViewDelegate, InfiniteTableViewDataSource {
    func initiate() {
        super.delegate = self
        super.collectionViewFlowLayout.minimumLineSpacing = CGFloat(0)
        super.collectionView.showsVerticalScrollIndicator = false
        super.initiate(nibName: String(describing: TodoListCell.self), dataSource: self)
    }

    func infiniteTableView(_ infiniteTableView: InfiniteTableView, itemsOn page: Int, callback: @escaping ([Any]) -> Void) {
        if(page > 1) {
            callback([Any]())
            return
        }

        ServerClient.getSchedules() { (todos) in
            callback(todos)
            EventBus.post(event: .todoListLoaded, data: todos.count)
        }
    }

    func infiniteTableView(_ infiniteTableView: InfiniteTableView, set cell: UICollectionViewCell, for item: Any) -> UICollectionViewCell {
        if let cell = cell as? TodoListCell {
            if let item = item as? TodoItem {
                cell.setItem(item)
            }
        }

        return cell
    }

}