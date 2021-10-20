//
//  WaterWaveView.m
//  MyProject
//
//  Created by liuyalu on 2021/9/30.
//

#import "WaterWaveView.h"

typedef NS_ENUM(NSInteger ,mCurveType) {
    
    mCurveTypeSin, // 正选
    mCurveTypeCos  // 余弦
};

@interface WaterWaveView ()
{
    CADisplayLink * _link;//定时器，刷新页面
    CGFloat _offset; //波纹移动的上下偏移
    CGFloat _waveHeight;//水的深度（不包含水纹）
    
    CAShapeLayer * waterLayer;//水的波纹
    CAShapeLayer * maskLayer; //水纹的遮罩层
    
    CGFloat _width; //视图宽度
    CGFloat _height;//视图高度
    

}


@end

@implementation WaterWaveView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height;
        [self setDefauletProperty];
    }
    
    return self;
}

- (void)layoutSubviews
{
    
    if (!waterLayer) {
        waterLayer = [CAShapeLayer layer];
        [self.layer addSublayer:waterLayer];
    }
    if (!maskLayer) {
        maskLayer = [CAShapeLayer layer];
        [self.layer addSublayer:maskLayer];
    }
    
}
//启动水波纹
-(void)startWave
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];//时间间隔为刷屏时间
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}
//停止水波纹
-(void)stopWave
{
    [_link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [_link invalidate];
    _link = nil;
}
#pragma  mark - 定时事件
-(void)displayLinkAction
{
    _offset += self.waveSpeed;
    
    UIBezierPath * sinPath = [self pathWithCurveType:mCurveTypeSin];
    waterLayer.path = sinPath.CGPath;
    waterLayer.fillColor = self.waveColor.CGColor;
    
    UIBezierPath * cosPath = [self pathWithCurveType:mCurveTypeCos];
    maskLayer.path = cosPath.CGPath;
    maskLayer.fillColor = self.maskColor.CGColor;
    
}

-(UIBezierPath *)pathWithCurveType:(mCurveType)type
{
    CGFloat startY = _waveHeight + _offset;
    UIBezierPath * mutablePath = [[UIBezierPath alloc] init];
    [mutablePath moveToPoint:CGPointMake(0, startY)];
    CGFloat y = 0;
    CGFloat x = 0;
    while (x < _width) {
        switch (type) {
            case 0:
                // y=Asin（ωx+φ）+h
                y = _waveHeight + self.peak * sin(x * 2 * M_PI/_width + _offset);
                break;
            case 1:
                y = _waveHeight + self.peak * cos(x * 2 * M_PI/_width + _offset);
                break;
            default:
                break;
        }
        [mutablePath addLineToPoint:CGPointMake(x, y)];
        x += 0.1;
    }
    [mutablePath addLineToPoint:CGPointMake(_width, _height)];
    [mutablePath addLineToPoint:CGPointMake(0, _height)];
    [mutablePath closePath];;
    return mutablePath;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    _waveHeight = (1 - percent) * self.bounds.size.height;
}

-(void)setDefauletProperty
{
    _waveHeight = self.bounds.size.height/2;
    self.peak = self.bounds.size.height/5;
    self.waveSpeed = 0.1;
    
}

@end
