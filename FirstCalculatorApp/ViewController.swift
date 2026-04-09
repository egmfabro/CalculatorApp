//
//  ViewController.swift
//  FirstCalculatorApp
//
//  Created by EFABRO on 4/1/26.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var historyTextField: UITextField!
    
    var viewModel = CalculatorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func onNumberPressed(_ sender: UIButton) {
        let digit = sender.configuration?.title ?? ""
        viewModel.receiveDigit(digit)
        updateUI()
    }
    
    @IBAction func onOperationPressed(_ sender: UIButton) {
        let id = sender.accessibilityIdentifier ?? ""
        let symbol = viewModel.getSymbol(from: id)
        
        viewModel.receiveOperation(symbol)
        updateUI()
    }
    
    @IBAction func onEqualPressed(_ sender: UIButton) {
        historyTextField?.text = viewModel.displayValue + "="
        viewModel.calculatedResult()
        updateUI()
        
        if let resultVC = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
            resultVC.finalResult = viewModel.displayValue
            navigationController?.pushViewController(resultVC, animated: true)
        }
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIButton) {
        viewModel.backspace()
        updateUI()
    }
    
    @IBAction func onClearButtonPressed(_ sender: UIButton) {
        viewModel.clearAll()
        updateUI()
    }
    
    func updateUI(){
        inputTextField.text = viewModel.displayValue
    }
}

