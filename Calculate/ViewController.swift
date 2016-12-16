//
//  ViewController.swift
//  Calculate
//
//  Created by Henrique Dourado on 12/12/16.
//  Copyright © 2016 Henrique Dourado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var firstNumberLbl: UILabel!
    @IBOutlet weak var secondNumberLbl: UILabel!
    @IBOutlet weak var operationLbl: UILabel!
    @IBOutlet weak var resultTxtField: UITextField!
    @IBOutlet weak var acertosLbl: UILabel!

    let operations = ["+", "-", "*"]
    
    var result = 0
    
    var partidas = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            playBtn.layer.cornerRadius = 10
            nextBtn.layer.cornerRadius = 10
        
            nextBtn.alpha = 0
            firstNumberLbl.alpha = 0
            secondNumberLbl.alpha = 0
            operationLbl.alpha = 0
            resultTxtField.alpha = 0
        
            acertosLbl.text = "Você ainda não começou a jogar"
    }
    
    @IBAction func playBtnPressed(_ sender: Any) {
        generateCalculus()
        
        UIView.animate(withDuration: 0.4) {
            (sender as! UIButton).alpha = 0
            self.nextBtn.alpha = 1
            self.firstNumberLbl.alpha = 1
            self.secondNumberLbl.alpha = 1
            self.operationLbl.alpha = 1
            self.resultTxtField.alpha = 1
        }
        
        acertosLbl.text = "O jogo começou"
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if let txt = resultTxtField.text, txt != "" {
            if Float(txt) == Float(result) {
                let alert = UIAlertController(title: "Parabéns", message: "Você acertou! O resultado é \(result)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (ok) in
                    self.generateCalculus()
                    self.resultTxtField.text = ""
                    self.partidas.append(1)
                    
                     self.acertosLbl.text = "Acertos: \(self.partidas.filter({$0 == 1}).count)/\(self.partidas.count)"
                }))
                present(alert, animated: true, completion: nil)
            } else {
                 let alert = UIAlertController(title: "Não foi dessa vez...", message: "Você errou!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                self.partidas.append(0)
            }
        } else {
            generateCalculus()
            self.partidas.append(0)
        }
        
        acertosLbl.text = "Acertos: \(partidas.filter({$0 == 1}).count)/\(partidas.count)"
    }
    
    
    func generateCalculus() {
        
        var numbs = [Int]()
        
        for x in 0...1000 {
            numbs.append(x)
        }
        
        let randomIndex1 = Int(arc4random_uniform(UInt32(numbs.count)))
        let randomIndex2 = Int(arc4random_uniform(UInt32(numbs.count)))
        
        var opInx = [Int]()
        
        for y in 0...2 {
            opInx.append(y)
        }
    
         let randomOperationInx = Int(arc4random_uniform(UInt32(opInx.count)))
        
        let numb1 = numbs[randomIndex1]
        let numb2 = numbs[randomIndex2]
        let opStr = operations[randomOperationInx]
        
        firstNumberLbl.text = String(numb1)
        secondNumberLbl.text = String(numb2)
        operationLbl.text = opStr
        
        if opStr == "+" {
            result = numb1 + numb2
        } else if opStr == "-" {
            result = numb1 - numb2
        } else if opStr == "*" {
            result = numb1 * numb2
        }
        
        if numb1 < numb2  {
            if opStr == "-"{
                generateCalculus()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

