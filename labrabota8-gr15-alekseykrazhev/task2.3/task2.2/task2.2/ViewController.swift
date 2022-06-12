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
    @IBOutlet var _circle: UIImageView!
    @IBOutlet var _square: UIImageView!
    var shadow_: Bool = false
    var gradient_: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        color = UIColor.orange.cgColor
        drawTrap()
        circlePathWithCenter()
        setGradientBackground()
        
        UIView.animate(withDuration: 0.7,
                           delay: 0.3,
                           options: [],
                           animations: { [weak self] in
                            self?.view.layoutIfNeeded()
              }, completion: nil)
        animate()
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
        
        let center = CGPoint(x: 200, y: 200)
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
        
        _circle.layer.addSublayer(circle)
    }
    
    func drawTrap() {
        let squarePath = UIBezierPath()
        squarePath.move(to: CGPoint(x: 100, y: 100))
                
        squarePath.addLine(to: CGPoint(x: 200, y: 100))
        squarePath.addLine(to: CGPoint(x: 250, y: 200))
        squarePath.addLine(to: CGPoint(x: 50, y: 200))
                
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
            _square.layer.addSublayer(gradient)
        } else {
            
            _square.layer.addSublayer(square)
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
    
    func animate(){
        // параметры анимации
        let options: UIView.AnimationOptions = [.curveEaseInOut,
                                                    .repeat,
                                                    .autoreverse]
        
        // анимация движения сектора круга
        UIView.animate(withDuration: 1.5,
                           delay: 0,
                           options: options,
                           animations: { [weak self] in
                            self?._circle.frame.size.height *= 1.18
                            self?._circle.frame.size.width *= 1.18
            }, completion: nil)
            
        // анимация движения для трапеции
        UIView.animate(withDuration: 1.5,
                           delay: 0,
                           options: options,
                           animations: { [weak self] in
                            self?._square.frame.size.height *= 1.18
                            self?._square.frame.size.width *= 1.18
            }, completion: nil)
        
        // анимация вращения трапеции
        UIView.animate(withDuration: 2.5,
                       delay: 0,
                       options: options) {[weak self] in
            self?._square.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        
        // анимация возвращения прозрачности от полностью прозрачного до непрозрачного
        _circle.alpha = 0
        UIView.animate(withDuration: 1, delay:0.01,
                                   options: options, animations:
                        {
                            ()-> Void in
                        },
                                            completion:{
                                            (finished:Bool) -> Void in
                                            UIView.animate(withDuration: 5, animations:{
                                                ()-> Void in
                                                self._circle.alpha = 1
                                            })
                    })

        UIView.animate(withDuration: 1, delay: 0.25,options: options,animations: {
                self._circle.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        }, completion: nil)
    }

}
