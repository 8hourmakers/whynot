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
    var nowSelected: Category?
    
    var relations: [UIView:Category] {
        return [
            beauty: .beauty,
            finance: .finance,
            friend: .friend,
            exersize: .exercise,
            study: .study,
            health: .health,
            living: .living,
            etc: .etc
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
        
        for btn in relations.keys {
            btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.btnClicked)))
        }
    }
    
    func btnClicked(_ gesture: UITapGestureRecognizer) {
        guard let clickedView = gesture.view,
              let clickedCategory = relations[clickedView] else {
            return
        }
        
        setCategory(clickedCategory)

        delegate?.categorySelectViewClicked(category: clickedCategory)
    }

    public func setCategory(_ category: Category) {
        nowSelected = category

        for (view, category) in relations {
            let label: UILabel = view.subviews.filter({$0 is UILabel}).first as! UILabel
            label.font = (category == nowSelected) ? UIFont.nanumBold.withSize(14) : UIFont.nanumLight.withSize(14)

            let imageView: UIImageView = view.subviews.filter({$0 is UIImageView}).first as! UIImageView
            imageView.image = (category == nowSelected) ? category.onImage : category.offImage
        }
    }
}

protocol CategorySelectViewDelegate {
    func categorySelectViewClicked(category: Category)
}


