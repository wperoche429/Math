//
//  StartViewController.swift
//  Math
//
//  Created by William Peroche on 23/06/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import Foundation
import UIKit

class StartViewController : UIViewController {
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var operationTextField: UITextField!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var value = [Int]()
        var operation = [String]()
        for i in 1...10 {
            if let button = view.viewWithTag(i) as? UIButton {
                if button.isSelected {
                    value.append(i)
                }
            }
        }
        
        
        for i in 100...103 {
            if let button = view.viewWithTag(i) as? UIButton {
                if button.isSelected {
                    operation.append(button.titleLabel!.text!)
                }
            }
        }
        
        
        guard let destination = segue.destination as? TestViewController else { return }
        destination.operationArray = operation
    }
    
    @IBAction func startAction() {
        var value = [Int]()
        var operation = [String]()
        for i in 1...10 {
            if let button = view.viewWithTag(i) as? UIButton {
                if button.isSelected {
                    value.append(i)
                }
            }
        }
        
        
        for i in 100...103 {
            if let button = view.viewWithTag(i) as? UIButton {
                if button.isSelected {
                    operation.append(button.titleLabel!.text!)
                }
            }
        }
        
        if value.count == 0 || operation.count == 0 {
            validateAlert()
            return
        }
        performSegue(withIdentifier: "start", sender: nil)
    }
    
    @IBAction func numberSelection(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func operationSelection(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    
    func validateAlert() {
        view.endEditing(true)
        let alertController = UIAlertController(title: "Make sure that numbers and operations are selected ", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { alert -> Void in
            
        })
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
