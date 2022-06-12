//
//  ViewController.swift
//  task5
//
//  Created by Кражевский Алексей И. on 5/13/22.
//

import UIKit

var first: Int = 0
var second: Int = 0
var res_: Int = 0
var isFirst: Bool = false
var error: Bool = false

class ViewController: UIViewController {

    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var operationSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var firstText: UITextField!
    @IBOutlet weak var secondText: UITextField!
    @IBOutlet weak var selectOption: UISegmentedControl!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var answerOptions: UISegmentedControl!
    @IBOutlet weak var var1: UILabel!
    @IBOutlet weak var var2: UILabel!
    @IBOutlet weak var var3: UILabel!
    @IBOutlet weak var var4: UILabel!
    @IBOutlet weak var var5: UILabel!
    @IBOutlet weak var result: UILabel!
    var correctIndex: Int = 0
    var isStarted: Bool = false
    
    @IBOutlet weak var res: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonClicked(_ sender: Any) {
        switch typeSegmentControl.selectedSegmentIndex{
        case 0:
            isFirst = true
            break
        case 1:
            isFirst = false
            break
        default:
            break
        }
        
        first = Int(firstText.text!)!
        second = Int(secondText.text!)!
        
        if (first % 10 == first) {
            res.text = "Wrong number type!"
            error = true
            return
        }
        
        if (second % 10 == second) {
            res.text = "Wrong number type!"
            error = true
            return
        }
        
        if (isFirst){
            if (first % 100 != first) {
                res.text = "Wrong number type!"
                error = true
                return
            }
            if (second % 100 != second) {
                res.text = "Wrong number type!"
                error = true
                return
            }
        }
        
        if (!isFirst){
            if (first % 1000 != first || first % 100 == first) {
                res.text = "Wrong number type!"
                error = true
                return
            }
            if (second % 1000 != second || second % 100 == second) {
                res.text = "Wrong number type!"
                error = true
                return
            }
        }
        
        switch operationSegmentControl.selectedSegmentIndex{
        case 0:
            res_ = first + second;
        case 1:
            res_ = first - second;
        default:
            res_ = -1
            break;
        }
        res.text = ""
        error = false
    }
    
    @IBAction func showCalculusTapped(_ sender: Any) {
        if (error) {
            textView.text = "Wrong number type!"
            return
        }
        
        var out: String;
        out = "Result = " + res_.description;
        
        result.text = out
    }
    
    @IBAction func chosedAnswer(_ sender: Any) {
        if (!isStarted){
            return
        }
        if (error) {
            textView.text = "Wrong number type!"
            return
        }
        
        if (answerOptions.selectedSegmentIndex == correctIndex) {
            textView.text = "Correct! Good job!"
        } else {
            textView.text = "Incorrect... Try once again!"
        }
    }
    
    @IBAction func quizStarted(_ sender: Any) {
        if (error) {
            textView.text = "Wrong number type!"
            return
        }
        
        var1.text = String(Int.random(in: 1...1999))
        var2.text = String(Int.random(in: 1...1999))
        var3.text = String(Int.random(in: 1...1999))
        var4.text = String(Int.random(in: 1...1999))
        var5.text = String(Int.random(in: 1...1999))
        
        let arr = [var1, var2, var3, var4, var5]
        let randomIndex = Int(arc4random_uniform(UInt32(arr.count)))
        
        switch randomIndex{
        case 0:
            var1.text = String(res_)
            break
        case 1:
            var2.text = String(res_)
            break
        case 2:
            var3.text = String(res_)
            break
        case 3:
            var4.text = String(res_)
            break
        case 4:
            var5.text = String(res_)
            break
        default:
            var2.text = String(res_)
            break
        }
        
        isStarted = true
        correctIndex = randomIndex
    }
    
}

