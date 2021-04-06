//
//  ViewController.swift
//  Calculator
//
//  Created by Svetlio on 2.04.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var resultLabel: UILabel!
    
    var result: NSNumber? {
        didSet {
            resultLabel.text = numberFormatter.string(from: result ?? 0)
        }
    }
    
    var firstNumber: NSNumber?
    var operation: String?
    var isStart = true
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 4
        nf.decimalSeparator = ","
        nf.usesGroupingSeparator = false
        return nf
    }()
    
    override func viewDidLayoutSubviews() {
        buttons.forEach {
            $0.layer.cornerRadius = 0.5 * $0.bounds.size.height
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons[1...].forEach {
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
        }
        buttons.first!.heightAnchor.constraint(equalTo: buttons.last!.widthAnchor).isActive = true
    }
    
    @IBAction func numberTap(_ sender: UIButton) {
        if resultLabel.text == "0" || isStart {
            resultLabel.text = sender.currentTitle!
        } else {
            resultLabel.text!.append(sender.currentTitle!)
        }
        isStart = false
    }
    
    @IBAction func comaTap(_ sender: UIButton) {
        if !resultLabel.text!.contains(",") {
            resultLabel.text!.append(",")
        }
    }
    
    @IBAction func operationTap(_ sender: UIButton) {
        result = numberFormatter.number(from: (resultLabel.text)!)
        if let firstNumber = firstNumber, operation != nil {
            switch operation {
            case "+":
                result = NSNumber(value: firstNumber.doubleValue + result!.doubleValue)
            case "-":
                result = NSNumber(value: firstNumber.doubleValue - result!.doubleValue)
            case "X":
                result = NSNumber(value: firstNumber.doubleValue * result!.doubleValue)
            case "/":
                result = NSNumber(value: firstNumber.doubleValue / result!.doubleValue)
            default:
                break // never
            }
            self.firstNumber = result
        } else {
            firstNumber = result
        }
        buttons.forEach {
            if $0.currentTitle == operation {
                $0.backgroundColor = UIColor(red: 244/256, green: 179/256, blue: 75/256, alpha: 1)
                $0.setTitleColor(.white, for: .normal)
            }
        }
        sender.backgroundColor = .white
        sender.setTitleColor(UIColor(red: 244/256, green: 179/256, blue: 75/256, alpha: 1), for: .normal)
        operation = sender.currentTitle!
        isStart = true
    }
    
    @IBAction func equalTap(_ sender: UIButton) {
        result = numberFormatter.number(from: (resultLabel.text)!)
        if let firstNumber = firstNumber, let result = result{
            switch operation {
            case "+":
                self.result = NSNumber(value: firstNumber.doubleValue + result.doubleValue)
            case "-":
                self.result = NSNumber(value: firstNumber.doubleValue - result.doubleValue)
            case "X":
                self.result = NSNumber(value: firstNumber.doubleValue * result.doubleValue)
            case "/":
                self.result = NSNumber(value: firstNumber.doubleValue / result.doubleValue)
            default:
                break
            }
        }
        buttons.forEach {
            if $0.currentTitle == operation {
                $0.backgroundColor = UIColor(red: 244/256, green: 179/256, blue: 75/256, alpha: 1)
                $0.setTitleColor(.white, for: .normal)
            }
        }
        firstNumber = nil
        operation = nil
        isStart = true
    }
    
    @IBAction func removeLast(_ sender: UIButton) {
        if resultLabel.text != nil, resultLabel.text! != ""{
            resultLabel.text!.removeLast()
        }
    }
    
    @IBAction func signChange(_ sender: UIButton) {
        if resultLabel.text!.first == "-" {
            resultLabel.text!.removeFirst()
        } else if resultLabel.text != "0" {
            resultLabel.text!.insert("-", at: resultLabel.text!.startIndex)
        }
    }
    
    @IBAction func numberColorChangeOnTap(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 165/256, green: 165/256, blue: 165/256, alpha: 1)
    }
    
    @IBAction func releaseNumber(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 51/256, green: 51/256, blue: 51/256, alpha: 1)
    }
    
    @IBAction func funcColorChangeOnTap(_ sender: UIButton) {
        sender.backgroundColor = .white
    }
    
    @IBAction func releaseFunc(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 165/256, green: 165/256, blue: 165/256, alpha: 1)
    }
}

