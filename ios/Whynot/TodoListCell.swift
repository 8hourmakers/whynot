//
//  TodoListCell.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 9. 3..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class TodoListCell: UICollectionViewCell {
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var repeatDayLabel: UILabel!
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    var viewTrailingOrigin:CGFloat = -140
    var item: TodoItem!
    
    func setItem(_ item: TodoItem) {
        self.item = item
        titleLabel.text = item.title
        repeatDayLabel.text = String(item.repeatDay)
        categoryIcon.image = item.category.icon

        let left = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        left.direction = .left
        self.addGestureRecognizer(left)

        let right = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        right.direction = .right
        self.addGestureRecognizer(right)

        EventBus.register(self, event: .todoCellExpanded, action: #selector(otherTodoCellExpanded))

        if(item.expanded) {
            self.expand(animated: false)
        } else {
            self.shrink(animated: false)
        }
    }

    @IBAction func modifyClicked() {
        EventBus.post(event: .todoCellModifyClicked, data: item)
    }

    @IBAction func deleteClicked() {
        EventBus.post(event: .todoCellDeleteClicked, data: item)
    }

    func otherTodoCellExpanded(_ notification: Notification) {
        guard let item = notification.object as? TodoItem else {
            return
        }

        if(self.item.id != item.id) {
            shrink()
        }
    }

    func swiped(_ sender: Any) {
        guard let gesture = sender as? UISwipeGestureRecognizer else {
            return
        }

        if(gesture.direction == .left) {
            EventBus.post(event: .todoCellExpanded, data: item)
            self.expand()
        } else if(gesture.direction == .right) {
            self.shrink()
        }
    }

    private func expand(animated: Bool = true) {
        viewTrailing.constant = 0
        item.expanded = true

        if(animated) {
            UIView.animate(
                    withDuration: 0.4,
                    animations: {
                        self.layoutIfNeeded()
                    }
            )
        } else {
            self.layoutIfNeeded()
        }
    }

    private func shrink(animated: Bool = true) {
        viewTrailing.constant = viewTrailingOrigin
        item.expanded = false

        if(animated) {
            UIView.animate(
                    withDuration: 0.4,
                    animations: {
                        self.layoutIfNeeded()
                    }
            )
        } else {
            self.layoutIfNeeded()
        }
    }
}
