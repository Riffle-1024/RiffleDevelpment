//
//  RippleView.m
//  MyProject
//
//  Created by mxchip on 2021/9/22.
//

#import "RippleView.h"

#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 设置静态常量 pulsingCount ，表示 Layer 的数量

static NSInteger const pulsingCount = 3;

// 设置静态常量 animationDuration ，表示动画时间

static double const animationDuration = 3;

@implementation RippleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multiple = 100;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CALayer *animationLayer = [CALayer layer];
    // 利用 for 循环创建三个动画 Layer
    
    for (int i = 0; i < pulsingCount; i++) {
        // 这里同时创建[缩放动画、背景色渐变、边框色渐变]三个简单动画
        NSArray * animationArray = [self animationArray];
        // 将三个动画合并为一个动画组
        // 通过传入参数 i 计算，错开动画时间
        CAAnimationGroup * animationGroup = [self animationGroupAnimations:animationArray index:i];
        
        //新建缩放动画
        //    CABasicAnimation * animation = [self scaleAnimation];
        
        //新建一个动画Layer，将动画添加上去
        
        CALayer * pulsingLayer = [self pulsingLayer:rect animation:animationGroup];
        //将动画Layer添加到animationLyer
        [animationLayer addSublayer:pulsingLayer];
    }
    
    
    
    //加入动画
    [self.layer addSublayer:animationLayer];
    
}

- (NSArray *)animationArray
{
    NSArray * animationArray = nil;
    CABasicAnimation * scaleAnimation = [self scaleAnimation];
    CAKeyframeAnimation * borderColorAnimation = [self borderColorAnimation];
    CAKeyframeAnimation * backgrounndAnimation = [self backgroundColorAnimation];
    animationArray = @[scaleAnimation,backgrounndAnimation,borderColorAnimation];
    return animationArray;
    
}


- (CAAnimationGroup *)animationGroupAnimations:(NSArray *)array index:(int)index
{
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    
    NSLog(@"%f",(double)(index * animationDuration) / (double)pulsingCount);
    
    animationGroup.beginTime = CACurrentMediaTime() + (double)(index * animationDuration) / (double)pulsingCount;
    animationGroup.duration = animationDuration;
    animationGroup.repeatCount = HUGE;
    animationGroup.animations = array;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    
    return animationGroup;
}

//实现缩放动画
- (CABasicAnimation *)scaleAnimation
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @(self.multiple);
//    scaleAnimation.beginTime = CACurrentMediaTime();
//    scaleAnimation.duration = 3;
//    scaleAnimation.repeatCount = HUGE;//重复次数为无限
    return scaleAnimation;
}

//新建CALyer,并在layer上加载动画。然后将这个Layer放在animationLyer上

- (CALayer *)pulsingLayer:(CGRect)rect animation:(CAAnimationGroup *)animationGroup {
    
    CALayer *pulsingLayer = [CALayer layer];
    
    
    
    pulsingLayer.borderWidth = 0.5;
    
    pulsingLayer.borderColor = [UIColor blackColor].CGColor;
    
    pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    pulsingLayer.cornerRadius = rect.size.height / 2;
    
    [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
    
    
    
    return pulsingLayer;
    
}


// 使用关键帧动画，使得颜色动画不要那么的线性变化

- (CAKeyframeAnimation *)backgroundColorAnimation
{
    CAKeyframeAnimation * backgroundColorAnimation = [CAKeyframeAnimation animation];
    backgroundColorAnimation.keyPath = @"backgroundColor";
    backgroundColorAnimation.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,
                                        (__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,
                                        (__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,
                                        (__bridge id)ColorWithAlpha(255, 241, 152, 0).CGColor];
    backgroundColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return backgroundColorAnimation;
}

- (CAKeyframeAnimation *)borderColorAnimation
{
    CAKeyframeAnimation * borderColorAnimation = [CAKeyframeAnimation animation];
    borderColorAnimation.keyPath = @"borderColor";
    borderColorAnimation.values = @[(__bridge id)ColorWithAlpha(255, 216, 87, 0.5).CGColor,
                                    (__bridge id)ColorWithAlpha(255, 231, 152, 0.5).CGColor,
                                    (__bridge id)ColorWithAlpha(255, 241, 197, 0.5).CGColor,
                                    (__bridge id)ColorWithAlpha(255, 241, 197, 0).CGColor,];
    borderColorAnimation.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return borderColorAnimation;
}
@end
