//
//  ViewController.swift
//  task2.2
//
//  Created by Кражевский Алексей И. on 6/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var backControl: UISegmentedControl!
    @IBOutlet var backColor: UISegmentedControl!
    @IBOutlet var color: CGColor!
    var shadow_: Bool = false
    var gradient_: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = UIColor.orange.cgColor
        drawTrap()
        circlePathWithCenter()
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.purple.cgColor, UIColor.yellow.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.locations = [0,1]
            gradientLayer.frame = self.view.bounds
            self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func circlePathWithCenter(){
        let circlePath = UIBezierPath()
        
        let center = CGPoint(x: 200, y: 400)
        let radius = 50
        
        circlePath.addArc(withCenter: center, radius: CGFloat(radius), startAngle: -CGFloat(Double.pi), endAngle: -CGFloat(Double.pi/2), clockwise: true)
        circlePath.addLine(to: center)
        
        circlePath.close()
        
        let circle = CAShapeLayer()
        circle.path = circlePath.cgPath
        circle.fillColor = color
        
        if (shadow_){
            circle.shadowColor = UIColor.darkGray.cgColor
            circle.shadowOffset = CGSize(width: 0.0, height: 2.8)
            circle.shadowOpacity = 1.0
            circle.shadowRadius = 1.0
            circle.shouldRasterize = true
            circle.rasterizationScale = UIScreen.main.scale
        }
        
        self.view.layer.addSublayer(circle)

    }
    
    func drawTrap() {
        let squarePath = UIBezierPath()
        squarePath.move(to: CGPoint(x: 100, y: 100))
                
        squarePath.addLine(to: CGPoint(x: 250, y: 100))
        squarePath.addLine(to: CGPoint(x: 200, y: 200))
        squarePath.addLine(to: CGPoint(x: 150, y: 200))
                
        squarePath.close()
        
        let square = CAShapeLayer()
        square.path = squarePath.cgPath
        square.fillColor = color
        
        if (shadow_){
            square.shadowColor = UIColor.darkGray.cgColor
            square.shadowOffset = CGSize(width: 0.0, height: 2.8)
            square.shadowOpacity = 1.0
            square.shadowRadius = 1.0
            square.shouldRasterize = true
            square.rasterizationScale = UIScreen.main.scale
        }
        
        if (gradient_){
            let gradientFrame = CGRect(x: 0,
                                           y: 0,
                                           width: 300,
                                           height: 300)
            let squareFrame = CGRect(x: 0,
                                         y: 0,
                                         width: 0,
                                         height: 0)
            square.frame = squareFrame

            let gradient = CAGradientLayer()
            gradient.frame = gradientFrame
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.colors = [UIColor.cyan.cgColor,
                               color!]
            gradient.mask = square
            self.view.layer.addSublayer(gradient)
        } else {
            self.view.layer.addSublayer(square)
        }
    }
    
    @IBAction func backChanged(_ sender: Any) {
        
        switch (backControl.selectedSegmentIndex){
        case 0:
            shadow_ = false
            gradient_ = false
            break
        case 1:
            gradient_ = true
            shadow_ = false
            break
        case 2:
            shadow_ = true
            gradient_ = false
            break
        default:
            break
        }
        
        circlePathWithCenter()
        drawTrap()
    }
    
    @IBAction func colorChanged(_ sender: Any) {
        switch (backColor.selectedSegmentIndex){
        case 0:
            color = UIColor.orange.cgColor
            break
        case 1:
            color = UIColor.red.cgColor
            break
        case 2:
            color = UIColor.blue.cgColor
            break
        case 3:
            color = UIColor.black.cgColor
            break
        default:
            color = UIColor.orange.cgColor
            break
        }
        
        drawTrap()
        circlePathWithCenter()
    }
}

