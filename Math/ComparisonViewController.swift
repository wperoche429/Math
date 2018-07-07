//
//  ComparisonViewController.swift
//  Math
//
//  Created by William Peroche on 7/07/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import UIKit

class ComparisonViewController : UIViewController {
    
    @IBOutlet var formulaLabel: UILabel!
    @IBOutlet var responseLabel: UILabel!
    var leftNum = 0
    var rightNum = 0
    var answer = ""
    
    var date = Date()
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formulaLabel.text = ""
        responseLabel.text = ""
        
        timer = Timer.scheduledTimer(timeInterval: 60 * 15, target: self, selector: #selector(finishAction), userInfo: nil, repeats: false)
        
        compare()
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
    
    @objc func compare() {
        date = Date()
        leftNum = Int(arc4random_uniform(20))
        rightNum = Int(arc4random_uniform(20))
        
        if leftNum < rightNum {
            answer = "<"
        } else if leftNum > rightNum {
            answer = ">"
        } else {
            answer = "="
        }
        responseLabel.text = ""
        formulaLabel.text = "\(leftNum) ___ \(rightNum)"
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        var input = ""
        
        switch sender.tag {
        case 1:
            input = "<"
        case 2:
            input = ">"
        case 3:
            input = "="
        default:
            break
        }
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        
        let test = Test()
        test.formula = "\(formulaLabel.text!) \(input) :: \(answer)"
        test.isCorrect = input == answer
        test.dateString = dateFormatter.string(from: currentDate)
        test.timeString = timeFormatter.string(from: currentDate)
        test.timeSpent = currentDate.timeIntervalSince(date)
        
        ResultManager.instance.add(test: test)
        
        if input == answer {
            responseLabel.text = "Correct"
            formulaLabel.text = "\(leftNum) \(input) \(rightNum)"
            
            perform(#selector(compare), with: nil, afterDelay: 3)
        } else {
            tryAgain()
            return
        }
        
    }
    
    func tryAgain() {
        view.endEditing(true)
        let alertController = UIAlertController(title: "The answer is not correct. Try again.", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { alert -> Void in
            
        })
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
