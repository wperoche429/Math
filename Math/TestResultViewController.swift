//
//  TestResultViewController.swift
//  Math
//
//  Created by William Peroche on 24/06/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import Foundation
import UIKit

class TestResultViewController : UIViewController {
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var dateString : String = ""
    var tests = [Test]()
    var wrongOnly = false
    var filteredTest = [Test]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tests = ResultManager.instance.getTests(forDate: dateString)
        filteredTest = tests
        
        let correct = tests.filter{ $0.isCorrect }
        resultLabel.text = "\(correct.count) / \(tests.count)"
    }
    
    @IBAction func clearAction(_ sender: Any) {
        ResultManager.instance.clear(dateString: dateString)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        wrongOnly = !wrongOnly
        
        if wrongOnly {
            filteredTest = tests.filter { !$0.isCorrect }
            
        } else {
            filteredTest = tests
        }
        
        tableView.reloadData()
    }
}

extension TestResultViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let test = filteredTest[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell")
        cell?.textLabel?.text = "[\(test.formula)]   [Time: \(test.timeString)]  [Spent: \(Int(test.timeSpent))] - [IsCorrect: \(test.isCorrect)]"
        
        cell?.backgroundColor = test.isCorrect ? .clear : .red
        
        return cell ?? UITableViewCell()
    }
}
