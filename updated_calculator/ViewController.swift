//
//  ViewController.swift
//  updated_calculator
//
//  Created by Ashutosh on 9/12/17.
//  Copyright © 2017 Ashutosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var prior = ""
    var bool = false //used to determine whether or not the label should be cleared (i.e if error is found and user enters a number again)
    var areThereTwoNumbers = false
    var countNumbers = 0
    var counter = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    
    @IBAction func percentage(_ sender: UIButton) {
        let str = label.text!
        if(str.components(separatedBy: .whitespaces).count  > 1){ return}
        else if(label.text! == "Error"){ return }
        let val = Double(label.text!)!/100.0
        label.text = String(val)
    }
    
    @IBAction func negate(_ sender: UIButton) {
        let str = label.text!
        if(str.components(separatedBy: .whitespaces).count  > 2){ if(str.components(separatedBy: .whitespaces)[2] == ""){return}}
        if(label.text! == "Error"){ return }
        if(label.text!.range(of:"-") == nil){
            label.text = "-" + label.text!
        }
        else{
            let index = label.text!.index(label.text!.startIndex, offsetBy: 1)
            label.text = label.text!.substring(from: index)
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        counter = 0
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        if label.text! == "0" || label.text == "Error" || bool || label.text! == "-0" {
            bool = false
            label.text = String(sender.tag-1)
        }
        else{
            label.text = label.text! + String(sender.tag-1)
        }
    }
    
    @IBAction func point(_ sender: UIButton) {
        if label.text! == "Error" || label.text!.range(of:".") != nil { return }
        if(!(label.text!.range(of:"+") == nil && label.text!.range(of:"-") == nil && label.text!.range(of:"÷") == nil && label.text!.range(of:"×") == nil)){
            label.text = label.text! + "0."
        }
        else{
        label.text = label.text! + "."
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        if(label.text! == "Error"){ return }
        if((label.text!.range(of:"+") == nil && label.text!.range(of:"-") == nil && label.text!.range(of:"÷") == nil && label.text!.range(of:"×") == nil) || counter == 0){
            prior = label.text!
            switch (sender.tag){
            case 11:
                label.text = label.text! + " × "
            case 12:
                label.text = label.text! + " - "
            case 13:
                label.text = label.text! + " + "
            case 14:
                label.text = label.text! + " ÷ "
            default:
                label.text = label.text!
            }
            counter = 1
        }
        else if(!(label.text!.range(of:"+") == nil && label.text!.range(of:"-") == nil && label.text!.range(of:"÷") == nil && label.text!.range(of:"×") == nil) && label.text!.components(separatedBy: .whitespaces).count > 2){
            if(label.text!.components(separatedBy: .whitespaces)[2] != ""){return} 
            switch (sender.tag){
            case 11:
                label.text = prior + " × "
            case 12:
                label.text = prior + " - "
            case 13:
                label.text = prior + " + "
            case 14:
                label.text = prior + " ÷ "
            default:
                label.text = label.text!
            }
            counter = 1
        }
        bool = false
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        let str = label.text!
        if(str.components(separatedBy: .whitespaces).count  > 2){ if(str.components(separatedBy: .whitespaces)[2] == ""){return}}
        else if(str.components(separatedBy: .whitespaces).count == 1 || str == "Error"){ return }
        let myStringArr = str.components(separatedBy: .whitespaces)
        let length = myStringArr.count
        var finalval = 0.0
        if length == 1 {}
        else{
            for index in stride(from: 0, to: length, by: 3){
                switch (myStringArr[index+1]){
                case "-":
                    finalval += Double(myStringArr[index])! - Double(myStringArr[index+2])!
                case "+":
                    finalval += Double(myStringArr[index])! + Double(myStringArr[index+2])!
                case "×":
                    finalval += Double(myStringArr[index])! * Double(myStringArr[index+2])!
                case "÷":
                    if(Double(myStringArr[index+2])! != 0.0){
                        finalval += Double(myStringArr[index])!/Double(myStringArr[index+2])!}
                    else{
                        label.text = "Error"
                        return
                    }
                default:
                    finalval += 0
                }
            }
        }
        if finalval == Double(Int(finalval)){
            label.text = String(Int(finalval))
        }
        else{
            label.text = String(finalval)}
        bool = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button0.isExclusiveTouch = true
        button1.isExclusiveTouch = true
        button2.isExclusiveTouch = true
        button3.isExclusiveTouch = true
        button4.isExclusiveTouch = true
        button5.isExclusiveTouch = true
        button6.isExclusiveTouch = true
        button7.isExclusiveTouch = true
        button8.isExclusiveTouch = true
        button9.isExclusiveTouch = true
        button10.isExclusiveTouch = true
        button11.isExclusiveTouch = true
        button12.isExclusiveTouch = true
        button13.isExclusiveTouch = true
        button14.isExclusiveTouch = true
        button15.isExclusiveTouch = true
        button16.isExclusiveTouch = true
        button17.isExclusiveTouch = true
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

