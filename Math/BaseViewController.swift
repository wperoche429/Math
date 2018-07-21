//
//  BaseViewController.swift
//  Math
//
//  Created by William Peroche on 7/07/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController {
 
    var date = Date()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd MMM yyyy"
        timeFormatter.dateFormat = "hh:mm a"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc func finishAction() {
        
    }
    

}


