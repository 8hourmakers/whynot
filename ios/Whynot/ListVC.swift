//
//  ListVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 11..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class ListVC: UIViewController, CategorySelectViewDelegate {

    @IBOutlet weak var categorySelectView: CategorySelectView!
    @IBOutlet weak var todoNumberLabel: UILabel!
    @IBOutlet weak var todoTableView: TodoTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        categorySelectView.delegate = self
        todoTableView.initiate()

        EventBus.register(self, event: .todoCellDeleteClicked, action: #selector(todoCellDeleteClicked))
        EventBus.register(self, event: .todoListLoaded, action: #selector(todoListLoaded))
    }

    @IBAction func categorySelectClicked() {

    }

    @IBAction func searchClicked() {

    }

    func todoCellDeleteClicked() {
        showAlertView(
                title: "할 일 삭제",
                msg: "할 일을 삭제하시겠습니까?",
                preferredStyle: .alert,
                actions: [
                        UIAlertAction(title: "예", style: .default, handler: nil),
                        UIAlertAction(title: "아니오", style: .cancel, handler: nil)
                ]
        )
    }

    func  todoListLoaded(_ notification: Notification) {
        guard let todoNum = notification.object as? Int else {
            return
        }

        todoNumberLabel.text = String(todoNum)
    }
    
    func categorySelectViewClicked(category: CategoryItem) {
        print(category)
    }
}
