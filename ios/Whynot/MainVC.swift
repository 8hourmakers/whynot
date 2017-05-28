//
//  ViewController.swift
//  Whynot
//
//  Created by Noverish Harold on 2017. 5. 28..
//  Copyright © 2017년 Noverish Harold. All rights reserved.
//

import UIKit

class MainVC: BaseVC {

    @IBOutlet weak var todoTableView:TodoTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.initialize(nowVC:self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

