//
//  DateResultViewController.swift
//  Math
//
//  Created by William Peroche on 24/06/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import Foundation
import UIKit


class DateResultViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var dataArray = [String]()
    var isValid = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isValid {
            self.checkPassword()
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        ResultManager.instance.clearAll()
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TestResultViewController,
            let dateString = sender as? String else { return }
        destination.dateString = dateString
    }
    
    func checkPassword() {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textfield) in
            textfield.isSecureTextEntry = true
            textfield.placeholder = ""
        }
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [unowned self] alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            
            guard let password = firstTextField.text else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            if password == "WilliamPeroche" {
                self.isValid = true
                self.dataArray = ResultManager.instance.getDateArray()
                self.tableView.reloadData()
            } else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            [unowned self]  (action : UIAlertAction!) ->Void in
            
            self.navigationController?.popViewController(animated: true)
            return
        })
        
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension DateResultViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell")
        cell?.textLabel?.text = dataArray[indexPath.row]
        
        return cell ?? UITableViewCell()
    }
    
    
}

extension DateResultViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Test", sender: dataArray[indexPath.row])
    }
}
