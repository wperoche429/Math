//
//  TestViewController.swift
//  Math
//
//  Created by William Peroche on 23/06/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import UIKit


class TestViewController: BaseViewController {


    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    
    
    var firstArray = [1,2,3,4,5,6,7,8,9,10]
    private let second = [0,1,2,3,4,5,6,7,8,9]
    var operationArray = ["+", "-", "x"]
    
    var randomFirst = [Int]()
    var randomSecond = [Int]()
    var randomOperator = [String]()
    var formula = ""
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textLabel.text = ""
        answerTextField.delegate = self
        nextAction()
    }
    
    @IBAction func nextAction() {
        date = Date()
        answerTextField.text = ""
        answerLabel.text = ""
        if randomFirst.count == 0 {
            randomFirst = firstArray.shuffled()
        }
        
        if randomSecond.count == 0 {
            randomSecond = second.shuffled()
        }
        
        if randomOperator.count == 0 {
            randomOperator = operationArray.shuffled()
        }
        
        formula = ""
        switch randomOperator[0] {
        case "+":
            formula = "\(randomFirst[0]) \(randomOperator[0]) \(randomSecond[0]) ="
        case "-":
            var high = randomFirst[0]
            var low = randomSecond[0]
            
            if high < low {
                low = high
                high = randomSecond[0]
                
            }
            formula = "\(high) \(randomOperator[0]) \(low) ="

        case "x":
            formula = "\(randomFirst[0]) \(randomOperator[0]) \(randomSecond[0]) ="
        case "/":
            let bottom = randomSecond[0] == 0 ? 1 : randomSecond[0]
            formula = "\(randomFirst[0]) \(randomOperator[0]) \(bottom) ="
        default:
            formula = ""
        }
        
        textLabel.text = formula
        answerTextField.becomeFirstResponder()
        
    }
    
    @objc func textFieldActive() {
        answerTextField.becomeFirstResponder()
        answerLabel.text = ""
    }
    
    @IBAction func answerAction() {
        guard let answer = answerTextField.text,
            let answerValue = Int(answer) else {
                answerTextField.text = ""
                answerLabel.text = "Please answer"
                view.endEditing(true)
                perform(#selector(textFieldActive), with: nil, afterDelay: 3)
                return
        }
        var result = 0
        switch randomOperator[0] {
        case "+":
            result = randomFirst[0] + randomSecond[0]
        case "-":
            var high = randomFirst[0]
            var low = randomSecond[0]
            
            if high < low {
                low = high
                high = randomSecond[0]
                
            }
            result = high - low
            
        case "x":
            result = randomFirst[0] * randomSecond[0]
        case "/":
            let bottom = randomSecond[0] == 0 ? 1 : randomSecond[0]
            result = randomFirst[0] / bottom
        default:
            result = 0
        }
        
        let currentDate = Date()

        let test = Test()
        test.formula = "\(formula) \(answerValue) :: \(result)"
        test.isCorrect = answerValue == result
        test.dateString = dateFormatter.string(from: currentDate)
        test.timeString = timeFormatter.string(from: currentDate)
        test.timeSpent = currentDate.timeIntervalSince(date)
        
        ResultManager.instance.add(test: test)
        
        if answerValue == result {
            answerLabel.text = "Correct"
            perform(#selector(backPage), with: nil, afterDelay: 2)
        } else {
            tryAgain()
            return
        }
        
        if operationArray.count != 1 {
            randomOperator.remove(at: 0)
        }
        
        randomFirst.remove(at: 0)
        randomSecond.remove(at: 0)
        view.endEditing(true)
        
    }
    
    @objc func backPage() {
        count += 1
        if count == 5 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.nextAction()
        }
    }
    
    func tryAgain() {
        view.endEditing(true)
        let alertController = UIAlertController(title: "The answer is not correct. Try again.", message: "", preferredStyle: UIAlertControllerStyle.alert)

        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [unowned self] alert -> Void in
            self.answerTextField.text = ""
            self.answerTextField.becomeFirstResponder()
            
        })
        
        alertController.addAction(saveAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

extension TestViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerAction()
        return true
    }
}

