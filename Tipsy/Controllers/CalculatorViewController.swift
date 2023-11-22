//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
var numberOfPeople = Int()
var tipPercentage = String()
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        let tipValueSelected = sender.titleLabel?.text
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        billTextField.endEditing(true)
        
        tipPercentage = String(tipValueSelected?.dropLast() ?? "_")
        
    }
    
    @IBAction func steperValueChanged(_ sender: UIStepper) {
        sender.wraps = true
        sender.autorepeat = true
        
        let peopleSplit = String(Int(sender.value))
        splitNumberLabel.text = peopleSplit
        numberOfPeople = Int(peopleSplit) ?? 0
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func getResultsSettingsText() -> String {
        let resultsText = "Split between \(numberOfPeople) people, with \(tipPercentage) tip."
        return resultsText
    }
    
    func getTotalValue() -> String {
        let billTotal = Float(billTextField.text ?? "0") ?? 0
        let tip = Float(tipPercentage) ?? 0
        let splitNumber = Float(numberOfPeople)
        
        let results = (billTotal / 100 * tip + billTotal) / splitNumber
        
        let totalValue = String(format: "%.2f", results)
        
        return totalValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.settingsText = getResultsSettingsText()
            destinationVC.totalValue = getTotalValue()
        }
    }
}

