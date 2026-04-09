//
//  ResultViewController.swift
//  FirstCalculatorApp
//
//  Created by EFABRO on 4/10/26.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    var finalResult: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = finalResult
    }
    
    @IBAction func onGoBackPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
