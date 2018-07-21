//
//  ComparisonViewController.swift
//  Math
//
//  Created by William Peroche on 7/07/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import UIKit

class ComparisonViewController :  BaseViewController {
    
    @IBOutlet var formulaLabel: UILabel!
    @IBOutlet var responseLabel: UILabel!
    var leftNum = 0
    var rightNum = 0
    var answer = ""
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        formulaLabel.text = ""
        responseLabel.text = ""
        
        compare()
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
            
            perform(#selector(backPage), with: nil, afterDelay: 3)
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
    
    @objc func backPage() {
        count += 1
        if count == 5 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.compare()
        }
    }
    
}
