//
//  ViewController.swift
//  calculator
//
//  Created by Ashutosh on 9/11/17.
//  Copyright © 2017 Ashutosh. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var counter = 0
    @IBOutlet weak var label: UILabel!
    
    @IBAction func negate(_ sender: UIButton) {
        label.text = "-" + label.text!
    }
    
    @IBAction func percentage(_ sender: UIButton) {
        let val = Double(label.text!)!/100.0
        label.text = String(val)
        
    }
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
    }
    @IBAction func numbers(_ sender: UIButton) {
        if label.text! == "0" {
            label.text = String(sender.tag-1)
        }
        else{
            label.text = label.text! + String(sender.tag-1)
        }
    }
    
    @IBAction func point(_ sender: UIButton) {
        label.text = label.text! + "."
    }
    
    @IBAction func operate(_ sender: UIButton) {
        if((label.text!.range(of:"+") == nil && label.text!.range(of:"—") == nil && label.text!.range(of:"÷") == nil && label.text!.range(of:"×") == nil) || counter == 0){
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
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        let str = label.text!
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
                        if(myStringArr[index+2] != "0"){
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

