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
    @IBOutlet var operatorLabel: UILabel!
    
    
    var operationArray = ["+", "-", "x"]
    
    var randomFirst = 0
    var randomSecond = 0
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
        if randomOperator.count == 0 {
            randomOperator = operationArray.shuffled()
        }
        
        formula = ""
        textLabel.textAlignment = .center
        operatorLabel.text = ""
        var display : String?
        switch randomOperator[0] {
        case "+":
            randomFirst = Int(arc4random_uniform(11))
            randomSecond = Int(arc4random_uniform(11))
            formula = "\(randomFirst) \(randomOperator[0]) \(randomSecond) ="
            textLabel.textAlignment = .right
            display = "\(randomFirst)\n\(randomSecond)"
            operatorLabel.text = "+"
        case "-":
            randomFirst = Int(arc4random_uniform(11))
            randomSecond = Int(arc4random_uniform(UInt32(randomFirst)))
            textLabel.textAlignment = .right
            display = "\(randomFirst)\n\(randomSecond)"
            formula = "\(randomFirst) \(randomOperator[0]) \(randomSecond) ="
            operatorLabel.text = "-"
        case "x":
            randomFirst = 1
            randomSecond = Int(arc4random_uniform(11))
            formula = "\(randomFirst) \(randomOperator[0]) \(randomSecond) ="
//        case "/":
//            let bottom = randomSecond[0] == 0 ? 1 : randomSecond[0]
//            formula = "\(randomFirst[0]) \(randomOperator[0]) \(bottom) ="
        default:
            formula = ""
        }
        
        textLabel.text = display ?? formula
        textLabel.sizeToFit()
        operatorLabel.font = textLabel.font
        
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
            result = randomFirst + randomSecond
        case "-":
            result = randomFirst - randomSecond
        case "x":
            result = randomFirst * randomSecond
//        case "/":
//            let bottom = randomSecond[0] == 0 ? 1 : randomSecond[0]
//            result = randomFirst[0] / bottom
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

