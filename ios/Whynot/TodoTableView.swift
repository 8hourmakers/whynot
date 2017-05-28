//
//  TodoTableView.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import Foundation
import UIKit

class TodoTableView: PagingTableView, PagingTableViewDelegate, PagingTableViewDataSource {
    func initialize(nowVC: UIViewController) {
        super.columnNum = 1
        super.sectionInset = CGFloat(0)
        super.itemSpacing = CGFloat(16)
        super.delegate = self
        super.initialize(nowVC: nowVC, dataSource: self)
    }
    
    func setItem(cell: UICollectionViewCell, item: Any) -> UICollectionViewCell {
//        if let cell = cell as? TodoCell {
//            if let item = item as? TodoItem {
//                cell.setItem(item)
//            }
//        }
        
        
        return cell
    }
    
    func loadMoreItems(page: Int, callback: @escaping ([Any]) -> Void) {
        callback(["","","","","","","","","","","","",""])
    }
    
    func getNibName() -> String {
        return "TodoCell"
    }
    
    func didSelected(item: Any) {
        
    }
    
    func calcHeight(width:CGFloat, item:Any) -> CGFloat {
        return CGFloat(50)
    }
}
