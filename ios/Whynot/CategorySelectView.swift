//
//  CategorySelectView.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 7. 11..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class CategorySelectView: UIView {

    @IBOutlet weak var beauty: UIView!
    @IBOutlet weak var living: UIView!
    @IBOutlet weak var health: UIView!
    @IBOutlet weak var study: UIView!
    @IBOutlet weak var exersize: UIView!
    @IBOutlet weak var friend: UIView!
    @IBOutlet weak var finance: UIView!
    @IBOutlet weak var etc: UIView!
    
    var delegate: CategorySelectViewDelegate?
    var nowSelected: TodoCategoryItem?
    
    var relation: [UIView:String] {
        return [
            beauty: "미용",
            living: "집안일",
            health: "건강",
            study: "학업",
            exersize: "운동",
            friend: "친목",
            finance: "금융",
            etc: "기타"
        ]
    }
    
    //코드에서 뷰를 생성할 때 호출 됨
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    //storyboard에 뷰를 사용할 때 호출 됨
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let view = Bundle.main.loadNibNamed(String(describing: CategorySelectView.self), owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        
        for btn in relation.keys {
            btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.btnClicked)))
        }
    }
    
    func btnClicked(_ gesture: UITapGestureRecognizer) {
        guard let clickedView = gesture.view, let clickedCategoryStr = relation[clickedView] else {
            print("[ERROR]")
            return
        }
        
        for view in relation.keys {
            let label:UILabel = view.subviews.filter({$0 is UILabel}).first as! UILabel
            label.textColor = (relation[view] == clickedCategoryStr) ? UIColor.black : UIColor.white
        }

        for category in ServerClient.categories {
            if category.name == clickedCategoryStr {
                nowSelected = category
                delegate?.categorySelectViewClicked(category: category)
            }
        }
    }
}

protocol CategorySelectViewDelegate {
    func categorySelectViewClicked(category: TodoCategoryItem)
}


