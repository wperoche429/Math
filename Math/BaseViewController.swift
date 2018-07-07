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
    var timer : Timer?
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd MMM yyyy"
        timeFormatter.dateFormat = "hh:mm a"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = timer {
            timer?.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(finishAction), userInfo: nil, repeats: false)
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let _ = timer {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func finishAction() {
        let alertController = UIAlertController(title: "Finish", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [unowned self] alert -> Void in
            self.navigationController?.popViewController(animated: true)
            return
            
        })
        
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

}


