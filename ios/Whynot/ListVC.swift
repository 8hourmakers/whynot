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
        EventBus.register(self, event: .todoCellModifyClicked, action: #selector(todoCellModifyClicked))
        EventBus.register(self, event: .todoListLoaded, action: #selector(todoListLoaded))
    }

    @IBAction func categorySelectClicked() {

    }

    @IBAction func searchClicked() {

    }

    func todoCellModifyClicked(_ notification: Notification) {
        guard let item = notification.object as? TodoItem else {
            return
        }

        print(self)
        self.performSegue(withIdentifier: "segTodoAdd", sender: item)
    }

    func todoCellDeleteClicked(_ notification: Notification) {
        guard let item = notification.object as? TodoItem else {
            return
        }
        
        showAlertView(
                title: "할 일 삭제",
                msg: "할 일을 삭제하시겠습니까?",
                preferredStyle: .alert,
                actions: [
                        UIAlertAction(title: "예", style: .default, handler: { action in self.todoDeleted(item) }),
                        UIAlertAction(title: "아니오", style: .cancel, handler: nil)
                ]
        )
    }
    
    private func todoDeleted(_ item: TodoItem) {
        todoTableView.deleteItem(item)
        ServerClient.deleteTodo(todoId: item.id)
    }

    func todoListLoaded(_ notification: Notification) {
        guard let todoNum = notification.object as? Int else {
            return
        }

        todoNumberLabel.text = String(todoNum)
    }
    
    func categorySelectViewClicked(category: Category) {
        print(category)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "segTodoAdd":
            if let vc = segue.destination as? TodoAddVC,
               let item = sender as? TodoItem {
                vc.modifyingItem = item
            }
            break
        default:
            break
        }
    }

}
