//
//  TodoCell.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class TodoCell: UICollectionViewCell {
    static let color1 = UIColor(red:63/255, green:180/255, blue:251/255, alpha:1)
    static let color2 = UIColor(red:131/255, green:209/255, blue:221/255, alpha:1)
    static let shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.3)
    
    @IBOutlet weak var root:UIView!
    @IBOutlet weak var bg:UIView!
    @IBOutlet weak var status:UIView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        status.layer.shadowColor = TodoCell.shadowColor.cgColor
        status.layer.shadowOpacity = 1
        status.layer.shadowOffset = CGSize.zero
        status.layer.shadowRadius = 2
        status.layer.cornerRadius = 15
        
//        root.layer.cornerRadius = 25
        root.layer.masksToBounds = false
        root.layer.shadowColor = TodoCell.shadowColor.cgColor
        root.layer.shadowOpacity = 1
        root.layer.shadowOffset = CGSize.zero
        root.layer.shadowRadius = 5
        
        
        let gradientLayer1 = CAGradientLayer()
        gradientLayer1.frame = self.bg.bounds
        gradientLayer1.colors = [TodoCell.color1.cgColor, TodoCell.color2.cgColor]
        gradientLayer1.cornerRadius = 25
        gradientLayer1.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer1.endPoint = CGPoint(x: 1, y: 1)
        
        bg.layer.addSublayer(gradientLayer1)
    }
    
    func setItem(_ item: TodoItem) {
        title.text = item.title
    }
}
