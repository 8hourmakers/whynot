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

    override func viewDidLoad() {
        super.viewDidLoad()

        categorySelectView.delegate = self
    }
    
    func categorySelectViewClicked(category: TodoCategoryItem) {
        print(category)
    }
}
