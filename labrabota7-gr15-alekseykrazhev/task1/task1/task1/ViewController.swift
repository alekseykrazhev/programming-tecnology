//
//  ViewController.swift
//  task1
//
//  Created by Alex on 5/6/22.
//  Copyright © 2022 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.textColor = UIColor.white
        label.text = "Background image: bg2.jpg"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2")!)
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backgroundSwitch: UISwitch!
    @IBAction func backgroundSwitchTapped(_sender: Any) {
        if backgroundSwitch.isOn {
            label.text = "Background image: bg2.jpg"
            view.backgroundColor = UIColor(patternImage: UIImage(named: "bg1")!) }
        else
        {
            label.text = "Background image: bg2.jpg"
            view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2")!) }
    }
}

