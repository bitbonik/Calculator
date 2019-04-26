//
//  ViewController.swift
//  Calculator
//
//  Created by Rajib on 20/4/19.
//  Copyright © 2019 Rajib. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {

    @IBOutlet weak var subDisplayLbl: UILabel!
    @IBOutlet weak var displayLbl: UILabel!
    var exp = ""
    var resultShown = false

    //MARK:- removing numbers from screen button functionality
    
    
    
    @IBOutlet var btnCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRound()
    }
    
    
    
    @IBAction func clearBtn(_ sender: UIButton) {
        if sender.currentTitle! == "c"{
            displayLbl.text = ""
            exp = ""
        }else{
            let txt = displayLbl.text!
            let subtxt = txt.dropLast()
            displayLbl.text = String(subtxt)
            exp = String(subtxt)
            
        }
    }
    
//MARK:- When any numbers or opertation button pressed
    
    @IBAction func numberBtn(_ sender: UIButton) {
        let currentCharacter = sender.currentTitle!
        //clears screen when new calculation begins
        if resultShown && (currentCharacter != "+" && currentCharacter != "-" && currentCharacter != "x" && currentCharacter != "÷"){
            displayLbl.text = ""
            exp = ""
        }
        resultShown = false
        displayLbl.text = displayLbl.text! + currentCharacter
        exp = exp + correctOperator(currentCharacter)
    }
    

//MARK:- When any = button pressed

    @IBAction func resulBtn(_ sender: UIButton) {
        var result: Double = 0.0
        let expression = Expression(exp)
        do{
            result = try expression.evaluate()
            subDisplayLbl.text = displayLbl.text! + " = " + String(format: "%g", result)
            displayLbl.text  =  String(format: "%g", result)
        }catch{
            print("Can't handle the operation\(error)")
            displayLbl.text = "Somthing Wrong!"
        }
        
        resultShown = true
        
  
    }
    
    func correctOperator(_ symbol: String) -> String{
        switch symbol {
        case "x":
            return "*"
        case "÷":
            return "/"
        default:
            return symbol
        }
    }
    
    
    func makeRound(){
        for btn in btnCollection{
            btn.layer.cornerRadius = btn.frame.size.width / 2
            btn.layer.masksToBounds = true
        }
    }
    
    
}

