//
//  ViewController.swift
//  task3
//
//  Created by Кражевский Алексей И. on 5/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activitySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateTapped(_ sender: Any) {
        let age: Float? = Float(ageTextField.text!);
        let height: Float? = Float(heightTextField.text!);
        let weight: Float? = Float(weightTextField.text!);
        var i: Float;
        i = weight! / (height!*height!) * 10000;
        
        var bmr: Float;
        bmr = 0;
        var amr: Float = 0;
        
        if (sexSegmentControl.selectedSegmentIndex == 0){
            bmr = 88.362;
            bmr += 13.397 * weight!;
            bmr += 4.799 * height!;
            bmr -= 5.677 * age!;
        }
        
        if (sexSegmentControl.selectedSegmentIndex == 1){
            bmr = 447.593;
            bmr += 9.247 * weight!;
            bmr += 3.098 * height!;
            bmr -= 4.330 * age!;
        }
        
        switch activitySegmentControl.selectedSegmentIndex{
        case 0:
            amr = 1.2;
        case 1:
            amr = 1.375;
        case 2:
            amr = 	1.55;
        case 3:
            amr = 1.725;
        default:
            break;
        }
        
        var a: Float;
        a = bmr * amr;
        var res: String;
        res = "You need to consume " + a.description + " calories to maintain your weight.\n Index of weight = " + i.description;
        
        resultLabel.text = res;
    }
    
}

