//
//  TodoAddVC.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class TodoAddVC: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    var modifyingItem: TodoItem?

    @IBOutlet weak var gradientBackground: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    @IBOutlet weak var todoField: UITextField!
    @IBOutlet weak var categorySelectView: CategorySelectView!
    @IBOutlet weak var repeatDayField: UITextField!
    @IBOutlet weak var wholeDaySwitch: UISwitch!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var categorySelectViewHeight: NSLayoutConstraint!
    var categorySelectViewHeightOrigin: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard)))
        todoField.delegate = self
        scrollView.delegate = self
        
        //transparent navigation bar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        categorySelectViewHeightOrigin = categorySelectViewHeight.constant

        if let item = modifyingItem {
            addBtn.title = "수정"

            todoField.text = item.title
            categorySelectView.setCategory(item.category)
            repeatDayField.text = String(item.repeatDay)
            startDatePicker.date = item.startDate
            endDatePicker.date = item.endDate
        } else {
            addBtn.title = "추가"
        }
    }
    
    @IBAction func addClicked() {
        hideKeyboard()
        
        guard let category = categorySelectView.nowSelected else {
            showToast("카테고리를 선택해 주세요")
            return
        }
        
        let title = todoField.text ?? ""
        if title == "" {
            showToast("할 일을 적어주세요")
            return
        }
        
        let repeatDayStr = repeatDayField.text ?? ""
        if repeatDayStr == "" {
            showToast("반복일을 적어주세요")
            return
        }

        guard let repeatDay = Int(repeatDayStr) else {
            showToast("반복일은 숫자이어야 합니다")
            return
        }

        let startDate = startDatePicker.date
        let endDate = endDatePicker.date

        if let modifyingItem = modifyingItem {
            ServerClient.modifyTodo(id: modifyingItem.id, title: title, category: category, startDate: startDate, endDate: endDate, repeatDay: repeatDay) { todoItem in
                
            }
            
            modifyingItem.title = title
            modifyingItem.category = category
            modifyingItem.startDate = startDate
            modifyingItem.endDate = endDate
            modifyingItem.repeatDay = repeatDay
            
            DispatchQueue.main.async {
                EventBus.post(event: .todoModified, data: modifyingItem)
                self.showToast("할 일 수정에 성공했습니다")
                self.dismiss(animated: true)
            }
        } else {
            ServerClient.makeTodo(title: title, category: category, startDate: startDate, endDate: endDate, repeatDay: repeatDay, memo: "", alarmMinute: 10) { todoItem in
                DispatchQueue.main.async {
                    EventBus.post(event: .todoAdded, data: todoItem)
                    self.showToast("할 일 추가에 성공했습니다")
                    self.dismiss(animated: true)
                }
            }
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        categorySelectViewHeight.constant = max(categorySelectViewHeightOrigin - offset, 0)
        self.view.layoutIfNeeded()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
