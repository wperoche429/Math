//
//  DecisionViewController.swift
//  Math
//
//  Created by William Peroche on 21/07/18.
//  Copyright © 2018 William Peroche. All rights reserved.
//

import UIKit

class DecisionViewController: UIViewController {

    let flow = ["clock", "compare", "compute"]
    var currentFlow = [String]()
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if count == 2000 {
            let alertController = UIAlertController(title: "Finish", message: "", preferredStyle: UIAlertControllerStyle.alert)
            let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { [unowned self] alert -> Void in
                self.navigationController?.popViewController(animated: true)
                return
                
            })
            
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if currentFlow.count == 0 {
            currentFlow = flow.shuffled()
        }
        
        let segue = currentFlow[0]
        currentFlow.remove(at: 0)
        performSegue(withIdentifier: segue, sender: nil)
        count += 1
    }
}
