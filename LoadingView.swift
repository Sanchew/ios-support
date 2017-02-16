//
//  LoadingView.swift
//  FTest
//
//  Created by lee on 2017/2/14.
//  Copyright © 2017年 clearlove. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    static override var layerClass: AnyClass {
        return CAGradientLayer.self
    }
//    var gradientLayer: CAGradientLayer {
//        return self.layer as! CAGradientLayer
//    }
    
    let gradientLayer = CAGradientLayer()
    let maskLayer = CALayer()
    fileprivate var animating = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
//    override var frame: CGRect{
//        set{
//            super.frame = newValue
////            gradientLayer.frame.size.height = newValue.height
//            if frame != CGRect.zero {
//                let mw = UIScreen.main.bounds.width
//                gradientLayer.frame = CGRect(x: 0, y: 0, width: mw, height: frame.height)
//                gradientLayer.position = CGPoint(x: mw, y: frame.height / 2.0)
//                startAnimating()
//            }
//        }
//        get {
//            return super.frame
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        configUI()
    }
    
    func configUI() {
        //        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0),UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5),UIColor(red: 0, green: 0, blue: 0, alpha: 0)]
        //        gradientLayer.frame = CGRect(x: 0, y: 0, width: 40, height: frame.height)
        //        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        //        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        //        gradientLayer.locations = [0,0.5,1]
        //        self.layer.addSublayer(gradientLayer)
        //        let layer = self.layer as! CAGradientLayer
        let layer = gradientLayer
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
//        var colors = [CGColor]()
//        for i in 0...3 {
//            colors.append(UIColor(hue: CGFloat(i) * 120  / 360.0, saturation: 1, brightness: 1, alpha: 1).cgColor)
//        }
//        layer.colors = colors
        layer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0),UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.1),UIColor(red: 0, green: 0, blue: 0, alpha: 0)].map{ $0.cgColor }
        layer.locations = [-1,-0.5,0]
        //        layer.frame = CGRect(x: -60, y: 0, width: 60, height: frame.height)
        layer.mask = maskLayer
//        maskLayer.frame = CGRect(x: 20, y: 20, width: 200, height: 200)
        self.layer.addSublayer(layer)
        self.layer.masksToBounds = true
//        startAnimating()
        perform(#selector(startAnimating), with:nil, afterDelay: 0.5)
        
        //        let layer = gradientLayer
        //        layer.frame = CGRect(x: 0, y: 0, width: 40, height: frame.height)
        ////        layer.position = center
        //        self.layer.addSublayer(layer)
        //        layer.colors = [UIColor.red.cgColor,UIColor.green.cgColor,UIColor.blue.cgColor]
        //        layer.locations = [0.25,0.5,0.75]
        //        layer.startPoint = CGPoint(x: 0, y: 0.5)
        //        layer.startPoint = CGPoint(x: 1, y: 0.5)
        //
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        self.layer.addSublayer(gradientLayer)
        let mask = CALayer()
        mask.frame = view.frame
        mask.backgroundColor = UIColor.black.cgColor
        maskLayer.addSublayer(mask)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        self.subviews.enumerated().forEach { (index,view) in
            maskLayer.sublayers?[index].frame = view.frame
        }
    }

    func performAnimation() {
//        let layer = self.layer as! CAGradientLayer
        let layer = gradientLayer
//        
//        let animation = CABasicAnimation(keyPath: "position.x")
//        animation.fromValue = -layer.frame.width
//        animation.toValue = UIScreen.main.bounds.width * 2
//        let distance = UIScreen.main.bounds.width + layer.frame.width
//        animation.duration = Double(distance) / 300
//        
//        
//        animation.isRemovedOnCompletion = false
//        animation.fillMode = kCAFillModeForwards
//        animation.delegate = self
//        layer.add(animation, forKey: "animateGradient")
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1,-0.5,0]
        animation.toValue = [1,1.5,2]
        let distance = UIScreen.main.bounds.width + layer.frame.width
        animation.duration = Double(distance) / 600
        animation.beginTime = CACurrentMediaTime() + 1
        
        
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        layer.add(animation, forKey: "animateGradient")

    }
    
    func startAnimating() {
        if !animating {
            animating = true
            performAnimation()
        }
    }
    
    func stopAnimating() {
        if animating {
            animating = false
        }
    }
}

extension LoadingView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if animating {
            performAnimation()
        }
    }
    
}
