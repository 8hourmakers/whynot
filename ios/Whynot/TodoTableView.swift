//
// Created by Noverish Harold on 2017. 9. 3..
// Copyright (c) 2017 Noverish Harold. All rights reserved.
//

import UIKit

class TodoTableView: InfiniteTableView, InfiniteTableViewDelegate, InfiniteTableViewDataSource {
    var keyword:String?
    var category:Category?
    
    func initiate() {
        super.delegate = self
        super.collectionViewFlowLayout.minimumLineSpacing = CGFloat(0)
        super.collectionView.showsVerticalScrollIndicator = false
        super.initiate(nibName: String(describing: TodoListCell.self), dataSource: self)

        EventBus.register(self, event: .todoAdded, action: #selector(self.todoAdded))
        EventBus.register(self, event: .todoModified, action: #selector(self.todoModified))
    }

    @objc private func todoAdded(_ notification: Notification) {
        guard let item = notification.object as? TodoItem else {
            return
        }

        super.insertItem(item)
    }

    @objc private func todoModified(_ notification: Notification) {
        guard let item = notification.object as? TodoItem else {
            return
        }

        super.modifyItem(item)
    }

    func infiniteTableView(_ infiniteTableView: InfiniteTableView, itemsOn page: Int, callback: @escaping ([Any]) -> Void) {
        if(page > 1) {
            callback([Any]())
            return
        }

        ServerClient.getMyTodo(keyword: keyword, category: category?.id) { (todos) in
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

    func infiniteTableView(_ infiniteTableView: InfiniteTableView, item lhs: Any, isEqualTo rhs: Any) -> Bool {
        guard let lhs = lhs as? TodoItem,
              let rhs = rhs as? TodoItem else {
            return false
        }

        return lhs.id == rhs.id
    }

}
