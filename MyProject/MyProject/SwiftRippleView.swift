//
//  SwiftRippleView.swift
//  MyProject
//
//  Created by liuyalu on 2021/10/2.
//

import UIKit

class SwiftRippleView: UIView {

    @objc var multiple:CGFloat = 0
    
    static let pulsingCuont = 3
    //设置静态变量animationDuration 表示动画时间
    static let animationDuration = 3.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        multiple = 100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //设置静态常量 pulsingCount，表示layer的数量

    override func draw(_ rect: CGRect) {
        
        let animationLayer = CALayer()
        // 利用 for 循环创建三个动画 Layer
        for i  in 0..<3 {
            // 这里同时创建[缩放动画、背景色渐变、边框色渐变]三个简单动画
            let animationArray:NSArray = animationArray()
            // 将三个动画合并为一个动画组
            // 通过传入参数 i 计算，错开动画时间
            let animationGroup:CAAnimationGroup = animationGroupAnimations(array: animationArray, index: i)
            //新建缩放动画
            //    CABasicAnimation * animation = [self scaleAnimation];
            
            //新建一个动画Layer，将动画添加上去
            let pulsingLayer:CALayer = pulsingLayer(rect: rect, animationGroup: animationGroup)
            //将动画Layer添加到animationLyer
            animationLayer.addSublayer(pulsingLayer)
        }
        
        //加入动画
        self.layer.addSublayer(animationLayer)
    }
    
    func animationArray() -> NSArray {
        
        let scaleAnimation:CABasicAnimation = scaleAnimation()
        let borderColorAnimation:CAKeyframeAnimation = borderColorAnimation()
        let backgrounndAnimation:CAKeyframeAnimation = backgroundColorAnimation()
        let animationArray:NSArray = [scaleAnimation,backgrounndAnimation,borderColorAnimation]
        
        
        return animationArray
    }
    
    
    func animationGroupAnimations(array:NSArray,index:Int) -> CAAnimationGroup {
        let animationGroup = CAAnimationGroup()
        print((index * Int(SwiftRippleView.animationDuration))/SwiftRippleView.pulsingCuont)
        animationGroup.beginTime = CACurrentMediaTime() + Double((index * Int(SwiftRippleView.animationDuration))/SwiftRippleView.pulsingCuont)
        animationGroup.duration = SwiftRippleView.animationDuration
        animationGroup.repeatCount = HUGE
        animationGroup.animations = array as? [CAAnimation]
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        
        return animationGroup
    }
    
//实现缩放动画
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation:CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = self.multiple
        
        
        return scaleAnimation
    }
    
    //新建CALyer,并在layer上加载动画。然后将这个Layer放在animationLyer上
    
    func pulsingLayer(rect:CGRect,animationGroup:CAAnimationGroup) -> CALayer{
        let pulsingLayer:CALayer = CALayer()
        pulsingLayer.borderWidth = 0.5
        pulsingLayer.borderColor = UIColor.black.cgColor
        
        pulsingLayer.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        pulsingLayer.cornerRadius = rect.size.height/2
        pulsingLayer.add(animationGroup,forKey: "plulsing")
        return pulsingLayer
    }
    
    func backgroundColorAnimation() -> CAKeyframeAnimation {
        let backgroundColorAnimation:CAKeyframeAnimation = CAKeyframeAnimation()
        backgroundColorAnimation.keyPath = "backgroundColor"
        backgroundColorAnimation.values = [colorWithAlpha(red: 255.0, green: 216.0, blue: 87.0, alpha: 0.5),
                                           colorWithAlpha(red: 255.0, green: 231.0, blue: 152.0, alpha: 0.5),
                                           colorWithAlpha(red: 255.0, green: 241.0, blue: 197.0, alpha: 0.5),
                                           colorWithAlpha(red: 255.0, green: 241.0, blue: 152.0, alpha: 0.5)]
        backgroundColorAnimation.keyTimes = [0.3,0.6,0.9,1]
        
        return backgroundColorAnimation
    }
    
    func borderColorAnimation() -> CAKeyframeAnimation {
        let borderColorAnimation:CAKeyframeAnimation = CAKeyframeAnimation()
        borderColorAnimation.keyPath = "borderColor"
        
        borderColorAnimation.values = [colorWithAlpha(red: 255.0, green: 216.0, blue: 87.0, alpha: 0.5),
                                       colorWithAlpha(red: 255.0, green: 231.0, blue: 152.0, alpha: 0.5),
                                       colorWithAlpha(red: 255.0, green: 241.0, blue: 197.0, alpha: 0.5),
                                       colorWithAlpha(red: 255.0, green: 241.0, blue: 197.0, alpha: 0)]
        borderColorAnimation.keyTimes = [0.3,0.6,0.9,1]
        
        return borderColorAnimation
    }
    
}
