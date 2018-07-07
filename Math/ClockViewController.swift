//
//  ClockViewController.swift
//  Math
//
//  Created by William Peroche on 7/07/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import UIKit
import BEMAnalogClock

class ClockViewController : BaseViewController {
    
    @IBOutlet var clock: BEMAnalogClockView!
    @IBOutlet var answerTextField: UITextField!
    @IBOutlet var answerLabel: UILabel!
    
    var minutes = [0,5,10,15,20,25,30,35,40,45,50,55]
    var hours = [1,2,3,4,5,6,7,8,9,10,11,12]
    var answer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        clock.hours = 0
        clock.minutes = 0
        clock.seconds = 0
        clock.hourHandLength = 55
        clock.minuteHandLength = 85
        clock.secondHandLength = 0
        
        
        nextAction()
    }
    
    @objc func nextAction() {
        date = Date()
        var newHour = hours.shuffled().first!
        var newMinute = minutes.shuffled().first!
        
        while newHour == clock.hours && newMinute == clock.minutes {
            newHour = hours.shuffled().first!
            newMinute = minutes.shuffled().first!
        }
        
        clock.hours = newHour
        clock.minutes = newMinute
        
        var minutesString = "\(clock.minutes)"
        if minutesString == "0" {
            minutesString = "00"
        } else if minutesString == "5" {
            minutesString = "05"
        }
        
        answerTextField.text = ""
        answerLabel.text = ""
        answer = "\(clock.hours):\(minutesString)"
        clock.updateTime(animated: true)
        answerTextField.becomeFirstResponder()
        
    }
    
    @objc func textFieldActive() {
        answerTextField.becomeFirstResponder()
        answerLabel.text = ""
    }
    
    @IBAction func checkAction(_ sender: UIBarButtonItem) {
        guard let answerValue = answerTextField.text,
                answerValue != "" else {
                answerTextField.text = ""
                answerLabel.text = "Please answer"
                view.endEditing(true)
                perform(#selector(textFieldActive), with: nil, afterDelay: 3)
                return
        }
        
        let currentDate = Date()
        
        let test = Test()
        test.formula = "\(answerValue) :: \(answer)"
        test.isCorrect = answerValue == answer
        test.dateString = dateFormatter.string(from: currentDate)
        test.timeString = timeFormatter.string(from: currentDate)
        test.timeSpent = currentDate.timeIntervalSince(date)
        
        ResultManager.instance.add(test: test)
        
        if answerValue == answer {
            answerLabel.text = "Correct"
            perform(#selector(nextAction), with: nil, afterDelay: 2)
        } else {
            tryAgain()
            return
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

