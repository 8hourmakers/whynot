//
//  ListVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 11..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class ListVC: UIViewController, CategorySelectViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var categorySelectView: CategorySelectView!
    @IBOutlet weak var todoNumberLabel: UILabel!
    @IBOutlet weak var todoTableView: TodoTableView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBOutlet weak var btnBarHeader: UIView!
    @IBOutlet weak var categoryHeader: UIView!
    @IBOutlet weak var searchHeader: UIView!
    @IBOutlet weak var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        categorySelectView.delegate = self
        searchField.delegate = self
        todoTableView.initiate()

        EventBus.register(self, event: .todoCellDeleteClicked, action: #selector(todoCellDeleteClicked))
        EventBus.register(self, event: .todoCellModifyClicked, action: #selector(todoCellModifyClicked))
        EventBus.register(self, event: .todoListLoaded, action: #selector(todoListLoaded))
    }

    @IBAction func categorySelectClicked() {
        setHeaderStatus(.category)
    }

    @IBAction func searchClicked() {
        setHeaderStatus(.search)
    }

    @IBAction func categoryApplyClicked() {
        guard let nowSelected = categorySelectView.nowSelected else { return }

        todoTableView.setFilter { item in
            guard let item = item as? TodoItem else { return false }

            return item.category == nowSelected
        }
    }

    @IBAction func categoryCancelClicked() {
        setHeaderStatus(.btnBar)
        todoTableView.setFilter(nil)
        categorySelectView.setCategory(nil)
    }

    @IBAction func searchApplyClicked() {
        todoTableView.setFilter({ item in
            guard let item = item as? TodoItem else { return false }

            return item.title.contains(self.searchField.text!)
        })
    }

    @IBAction func searchCancelClicked() {
        setHeaderStatus(.btnBar)
        todoTableView.setFilter(nil)
        searchField.text = ""
    }

    private func setHeaderStatus(_ status: HeaderStatus) {
        headerHeight.constant = (status == HeaderStatus.category) ? 265 : 70

        UIView.animate(
                withDuration: 0.4,
                animations: {
                    self.btnBarHeader.alpha = (status == HeaderStatus.btnBar) ? 1 : 0
                    self.categoryHeader.alpha = (status == HeaderStatus.category) ? 1 : 0
                    self.searchHeader.alpha = (status == HeaderStatus.search) ? 1 : 0
                    self.view.layoutIfNeeded()
                }
        )

        if(status == HeaderStatus.search) {
            searchField.becomeFirstResponder()
        } else {
            searchField.resignFirstResponder()
        }

    }

    func todoCellModifyClicked(_ notification: Notification) {
        guard let item = notification.object as? TodoItem else {
            return
        }
        
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

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchApplyClicked()
        self.hideKeyboard()
        return false
    }


    func categorySelectViewClicked(category: Category) {
        
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

    enum HeaderStatus {
        case btnBar
        case category
        case search
    }
}
