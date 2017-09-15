//
//  ViewController.swift
//  updated_calculator
//
//  Created by Ashutosh on 9/12/17.
//  Copyright © 2017 Ashutosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lastVersionOfDisplay = "" //used to replace operators if user accidentally types in wrong operator
    var isDisplayCleared = true //used to determine whether or not the label should be cleared (i.e if error is found and user enters a number again)
    var areThereTwoNumbers = false
    var isThereAnOperator = false //used as a measure to determine if an operator can be added to the label
    var calculatedValue = 0.0
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    
    
    func containsOperator() -> Bool {
        return label.text!.range(of:"+") != nil || label.text!.range(of:"-") != nil || label.text!.range(of:"÷") != nil || label.text!.range(of:"×") != nil
    }
    
    /**
     Set function that inserts an operator at the end of string
     - param Passes in string that comes from label.text or a prior version of it
     - param Passes in the button that was pressed (×, -, +, or ÷)
     */
    func insertOperator(textInLabel: String, sender: UIButton){
        switch (sender.tag){
        case 11:
            label.text = textInLabel + " × "
        case 12:
            label.text = textInLabel + " - "
        case 13:
            label.text = textInLabel + " + "
        case 14:
            label.text = textInLabel + " ÷ "
        default:
            label.text = textInLabel
        }
        isThereAnOperator = true
    }
    
    /**
     Set function that changes the content of label.text if there is only a single number in label.text shown by the lack of a white space
     - param % button
     - return Converts the string in label.text into a double and divides by 100.0, but only if there is only a single number in the label
     and converts result back into label
     */
    @IBAction func findPercentage(_ sender: UIButton) {
        let display = label.text!
        let numOfTermsInDisplay = display.components(separatedBy: .whitespaces).count
        let isErrorShown = display == "Error"
        
        if(numOfTermsInDisplay  > 1 || isErrorShown){
            return
        }
        
        let val = Double(display)!/100.0
        label.text = String(val)
    }
    
    /**
     Set function that changes the content of label.text when +/- button is pressed
     - param +/- button
     - return Negates the first number in the label.text
     */
    @IBAction func negateValue(_ sender: UIButton) {
        let display = label.text!
        let isErrorShown = display == "Error"
        
        if(isErrorShown){
            return
        }
        
        let components =  display.components(separatedBy: .whitespaces)
        let secondNumberAvailable = components.count > 2
        
        if(secondNumberAvailable){
            let secondNumberEmpty = components[2] == ""
            if(secondNumberEmpty){
                return
            }
        }
        
        let isNegateSymbolInDisplay = display.range(of:"-") != nil
        
        if(!isNegateSymbolInDisplay){
            label.text = "-" + display
        }
        else{
            let index = display.index(display.startIndex, offsetBy: 1)
            label.text = display.substring(from: index)
        }
    }
    
    /**
     - param 'C' button
     */
    @IBAction func clearDisplay(_ sender: UIButton) {
        label.text = "0"
        isThereAnOperator = false
    }
    
    /**
     Insert function that inserts digit string into label.text
     - param Any of the number buttons
     - return Inserts digit at the end of the label.text
     */
    @IBAction func insertNumbers(_ sender: UIButton) {
        let display = label.text!
        let isDisplayZero = display == "0" || display == "-0"
        let isDisplayError = display == "Error"
        
        if isDisplayZero || isDisplayError || !isDisplayCleared {
            isDisplayCleared = true
            label.text = String(sender.tag-1)
        }
        else{
            label.text = display + String(sender.tag-1)
        }
    }
    
    /**
     Insert function that inserts a point into label.text
     - param '.' button
     */
    @IBAction func addPoint(_ sender: UIButton) {
        let display = label.text!
        let isDisplayError = display == "Error"
        let isPointInDisplay = display.range(of:".") != nil
        
        if isDisplayError || isPointInDisplay {
            return
        }
        
        if(containsOperator()){
            label.text = display + "0."
        }
        else{
            label.text = display + "."
        }
    }
    
    /**
     Function that is called when one of the operators is pressed and checks if label.text already has an operator; if not, then an operator is added to label.text
     - param '×', '-', '+', or '÷' button
     */
    @IBAction func insertOperator(_ sender: UIButton) {
        let display = label.text!
        let components =  display.components(separatedBy: .whitespaces)
        let secondNumberAvailable = components.count > 2
        let isDisplayError = display == "Error"
        
        if isDisplayError {
            return
        }
        
        if(!containsOperator() || !isThereAnOperator){
            lastVersionOfDisplay = label.text!
            insertOperator(textInLabel: lastVersionOfDisplay, sender: sender)
        }
        else if(containsOperator() && secondNumberAvailable){
            let secondNumberNotEmpty = components[2] != ""
            if(secondNumberNotEmpty){
                return
            }
            insertOperator(textInLabel: lastVersionOfDisplay, sender: sender)
        }
        isDisplayCleared = true
    }
    
    func calculateValue(components : [String]) -> Bool {
        let isDivisorZero = Double(components[2])! == 0.0
        calculatedValue = 0.0
        
        switch (components[1]){
        case "-":
            calculatedValue = calculatedValue + Double(components[0])! - Double(components[2])!
        case "+":
            calculatedValue = calculatedValue + Double(components[0])! + Double(components[2])!
        case "×":
            calculatedValue = calculatedValue + Double(components[0])! * Double(components[2])!
        case "÷":
            if isDivisorZero {
                label.text = "Error"
                return true
            }
            calculatedValue = calculatedValue + Double(components[0])!/Double(components[2])!
        default:
            calculatedValue = calculatedValue + 0
        }
        
        return false
    }
    
    /**
     Calculate the value of the numbers in label.text
     - param '=' button
     */
    @IBAction func calculate(_ sender: UIButton) {
        let display = label.text!
        
        let components =  display.components(separatedBy: .whitespaces)
        let secondNumberAvailable = components.count > 2
        let isLengthOfComponentsOne = components.count == 1
        let isDisplayError = display == "Error"
        
        if(secondNumberAvailable){
            let secondNumberEmpty = components[2] == ""
            if(secondNumberEmpty){
                return
            }
        }
        else if(isLengthOfComponentsOne || isDisplayError){
            return
        }
        
        let isDivisorZero = calculateValue(components: components)
        
        if isDivisorZero {
            return
        }
        
        let isCalculatedValueAWholeNumber = calculatedValue == Double(Int(calculatedValue))
        
        if isCalculatedValueAWholeNumber {
            label.text = String(Int(calculatedValue))
        }
        else{
            label.text = String(calculatedValue)
        }
        
        isDisplayCleared = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttons.forEach { ( button: UIButton) in
            button.isExclusiveTouch = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
