//
//  ClockViewController.swift
//  Math
//
//  Created by William Peroche on 7/07/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import UIKit
import BEMAnalogClock

class ClockViewController : BaseViewController, UITextFieldDelegate {
    
    @IBOutlet var clock: BEMAnalogClockView!
    @IBOutlet var answerTextField: UITextField!
    @IBOutlet var answerLabel: UILabel!
    
    let minutes = [0,5,10,15,20,25,30,25,40,45,50,55]
    let hours = [1,2,3,4,5,6,7,8,9,10,11,12]
    var answer = ""
    let mode = [0,1,0,1,0,1,0,1,0,1,0,1,0,0,0,1,1,1,1,1,0,1,0,0,1,1]
    var currentMode = 0
    var currentHour = 0
    var currentMinute = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        clock.hours = 0
        clock.minutes = 0
        clock.seconds = 0
        clock.hourHandLength = 55
        clock.minuteHandLength = 85
        clock.secondHandLength = 0
        answerTextField.delegate = self
        
        nextAction()
    }
    
    @objc func nextAction() {
        date = Date()
        currentHour = hours.shuffled().first!
        currentMinute = minutes.shuffled().first!
        while currentHour == clock.hours && currentMinute == clock.minutes {
            currentHour = hours.shuffled().first!
            currentMinute = minutes.shuffled().first!
        }
        var minutesString = "\(currentMinute)"
        if minutesString == "0" {
            minutesString = "00"
        } else if minutesString == "5" {
            minutesString = "05"
        }
        
        currentMode = mode.shuffled().first!
        
        if currentMode == 0 {
            textInput(minutesString : minutesString)
        } else {
            clockInput(minutesString: minutesString)
        }
        answerLabel.text = ""
    }
    
    private func textInput(minutesString : String) {
        clock.hourHandColor = UIColor.black
        clock.minuteHandColor = UIColor.black
        clock.reloadClock()
        answerTextField.isUserInteractionEnabled = true
        clock.setTimeViaTouch = false

        clock.hours = currentHour
        clock.minutes = currentMinute
        
        answerTextField.text = ""
        
        answer = "\(clock.hours):\(minutesString)"
        clock.updateTime(animated: true)
        answerTextField.becomeFirstResponder()
    }
    
    private func clockInput(minutesString : String) {
        clock.hourHandColor = UIColor.blue
        clock.minuteHandColor = UIColor.blue
        clock.reloadClock()
        answerTextField.isUserInteractionEnabled = false
        clock.setTimeViaTouch = true

        
        answerTextField.text = "\(currentHour):\(minutesString)"
        answer = "\(currentHour):\(minutesString)"
    }
    
    @objc func textFieldActive() {
        answerTextField.becomeFirstResponder()
        answerLabel.text = ""
    }
    
    @IBAction func checkAction(_ sender: UIBarButtonItem) {
        let currentDate = Date()
        
        if currentMode == 0 {
            guard let answerValue = answerTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines),
                    answerValue != "" else {
                    answerTextField.text = ""
                    answerLabel.text = "Please answer"
                    view.endEditing(true)
                    perform(#selector(textFieldActive), with: nil, afterDelay: 3)
                    return
            }
            
            let test = Test()
            test.formula = "\(answerValue) :: \(answer) :: \(currentMode)"
            test.isCorrect = answerValue == answer
            test.dateString = dateFormatter.string(from: currentDate)
            test.timeString = timeFormatter.string(from: currentDate)
            test.timeSpent = currentDate.timeIntervalSince(date)
            
            ResultManager.instance.add(test: test)
            
            if answerValue == answer {
                answerLabel.text = "Correct"
                perform(#selector(backPage), with: nil, afterDelay: 2)
            } else {
                tryAgain()
                return
            }
        } else {
            let hour = clock.hours
            let minute = clock.minutes
            
            var minutesString = "\(minute)"
            if minutesString == "0" {
                minutesString = "00"
            } else if minutesString == "5" {
                minutesString = "05"
            }
            let answerValue = "\(hour):\(minutesString)"
            
            let test = Test()
            test.formula = "\(answerValue) :: \(answer) :: \(currentMode)"
            test.isCorrect = answerValue == answer
            test.dateString = dateFormatter.string(from: currentDate)
            test.timeString = timeFormatter.string(from: currentDate)
            test.timeSpent = currentDate.timeIntervalSince(date)
            
            ResultManager.instance.add(test: test)
            
            if answerValue == answer {
                answerLabel.text = "Correct"
                perform(#selector(backPage), with: nil, afterDelay: 2)
            } else {
                tryAgain()
                return
            }
        }
    }
    
    private func tryAgain() {
        view.endEditing(true)
        let alertController = UIAlertController(title: "The answer is not correct. Try again.", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [unowned self] alert -> Void in
            if self.currentMode == 0 {
                self.answerTextField.text = ""
                self.answerTextField.becomeFirstResponder()
            }
            
        })
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.checkAction(UIBarButtonItem())
        return true
    }
    
    @objc func backPage() {
        self.navigationController?.popViewController(animated: true)
    }
}

