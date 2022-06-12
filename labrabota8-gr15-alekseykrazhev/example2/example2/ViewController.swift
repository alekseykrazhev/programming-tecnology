//
//  ViewController.swift
//  example2
//
//  Created by Alex on 6/2/22.
//  Copyright © 2022 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let squarePath = UIBezierPath()
        squarePath.move(to: CGPoint(x: 100, y: 100))
        
        squarePath.addLine(to: CGPoint(x: 200, y: 100))
        squarePath.addLine(to: CGPoint(x: 200, y: 200))
        squarePath.addLine(to: CGPoint(x: 100, y: 200))
        
        squarePath.close()
        
        let square = CAShapeLayer()
        square.path = squarePath.cgPath
        square.fillColor = UIColor.red.cgColor
        
        self.view.layer.addSublayer(square)
        
        let circle = CAShapeLayer()
        circle.path = circlePathWithCenter(center: CGPoint(x: 200, y: 400), radius: 50).cgPath
        circle.fillColor = UIColor.blue.cgColor
        
        self.view.layer.addSublayer(circle)
    }
    
    func circlePathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(M_PI), endAngle: -CGFloat(M_PI/2), clockwise: true)
        
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat(M_PI/2), endAngle: 0, clockwise: true)
        
        circlePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI/2), clockwise: true)
        
        circlePath.addArc(withCenter: center, radius: radius, startAngle: CGFloat(M_PI/2), endAngle: CGFloat(M_PI), clockwise: true)
        
        return circlePath
    }


}

