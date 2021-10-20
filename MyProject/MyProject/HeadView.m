//
//  HeadView.m
//  MyProject
//
//  Created by mxchip on 2021/9/22.
//

#import "HeadView.h"
#import "TimerTarget.h"

#define mFIRSTWAVE_DEFAULT_COLOR [UIColor colorWithRed:223/255.0 green:83/255.0 blue:64/255.0 alpha:0.5]
#define mSECONDEWAVE_DEFAULT_COLOR [UIColor colorWithRed:236/255.0f green:90/255.0f blue:66/255.0f alpha:0.5]

#define mWATERWAVE_DEFAULT_SPEED 0.1;
#define mWATERWAVE_DEFAULT_PEAK  6.0
#define mWATERWAVE_DEFAULT_PERIOD 1.2
typedef NS_ENUM(NSInteger ,mCurveType) {
    
    mCurveTypeSin, // 正选
    mCurveTypeCos  // 余弦
};

@interface HeadView ()
{
    
    CADisplayLink *_link;
    CGFloat _changePercent;
    CGFloat _offSet;
    CGFloat _waveHeight;/**<水纹高度*/
    CGFloat _width;
    CGFloat _height;
    CAShapeLayer *_firstWaveLayer;
    CAShapeLayer *_secondWaveLayer;
}

@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        _height = frame.size.height;
        [self setDefaultProperty];

       
    }
    return self;
}


- (void)layoutSubviews {
    
    _width = self.frame.size.width;
    _height = self.frame.size.height;
    self.layer.cornerRadius = _width * 0.5;

    [self layoutWaveLayers];
}

#pragma mark **** 添加水波纹Layer
- (void)layoutWaveLayers {

    if (!self.firstWaveColor ) self.firstWaveColor = mFIRSTWAVE_DEFAULT_COLOR;
    if (!self.secondWaveColor) self.secondWaveColor = mSECONDEWAVE_DEFAULT_COLOR;
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_secondWaveLayer];
    }
    
    _firstWaveLayer.fillColor = self.firstWaveColor.CGColor;
    _secondWaveLayer.fillColor = self.secondWaveColor.CGColor;
}

- (void)startWave {

    if (_link == nil) {
        
        _link = [CADisplayLink displayLinkWithTarget:[TimerTarget timerTarget:self] selector:@selector(displayLinkAction)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}


- (void)stopWave {

    _changePercent = 0.0;
    [_link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [_link invalidate];
    _link = nil;
}


#pragma mark **** 定时器事件
- (void)displayLinkAction {
    
    _offSet -= _speed;
    
    [self percentChange];
    
    // 正弦曲线
    CGMutablePathRef sinPath = [self pathWithCurveType:mCurveTypeSin];
    _firstWaveLayer.path = sinPath;
    CGPathRelease(sinPath);
    
    // 余弦曲线
    CGMutablePathRef cosPath = [self pathWithCurveType:mCurveTypeCos];
    _secondWaveLayer.path = cosPath;
    CGPathRelease(cosPath);
}

#pragma mark **** 通过改变percent的值实现动画效果
- (void)percentChange {
    
    _changePercent += 0.005;
    if (_changePercent > _percent) {// 当定时器改变的值(_changePercent)大于设定的值(_percent)时停止变化【注意:不可以使用等于号】
        _changePercent -= 0.005;
    }
}

#pragma mark **** 通过曲线类型获得对应的曲线路径
- (CGMutablePathRef)pathWithCurveType:(mCurveType)curveType {

    _waveHeight = (1 - _changePercent) * _height;
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, nil, 0, _waveHeight);
    CGFloat y;
    for (CGFloat x = 0.0f; x < _width; x++) {
        switch (curveType) {
            case 0:
                y = _peak * sin(_period * M_PI / _width * x + _offSet) + _waveHeight;
                break;
            case 1:
                y = _peak * cos(_period * M_PI / _width * x + _offSet) + _waveHeight;
                break;
  
            default:
                break;
        }
        CGPathAddLineToPoint(mutablePath, nil, x, y);
    }
    CGPathAddLineToPoint(mutablePath, nil, _width, _height);
    CGPathAddLineToPoint(mutablePath, nil, 0, _height);
    CGPathCloseSubpath(mutablePath);
    return mutablePath;
}


+ (CGMutablePathRef)pathWithCurveType:(int)type WaveHeight:(CGFloat)_waveHeight
                       ChangePercent:(CGFloat)_changePercent
                              Height:(CGFloat)_height
                              Period:(CGFloat)_period
                               Width:(CGFloat)_width
                                Peak:(CGFloat)_peak
                              OffSet:(CGFloat)_offSet
                               Layer:(CAShapeLayer *)layer


{

    _waveHeight = (1 - _changePercent) * _height;
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, nil, 0, _waveHeight);
    CGFloat y;
    for (CGFloat x = 0.0f; x < _width; x++) {
        switch (type) {
            case 0:
                y = _peak * sin(_period * M_PI / _width * x + _offSet) + _waveHeight;
                break;
            case 1:
                y = _peak * cos(_period * M_PI / _width * x + _offSet) + _waveHeight;
                break;
  
            default:
                break;
        }
        CGPathAddLineToPoint(mutablePath, nil, x, y);
    }
    CGPathAddLineToPoint(mutablePath, nil, _width, _height);
    CGPathAddLineToPoint(mutablePath, nil, 0, _height);
    CGPathCloseSubpath(mutablePath);
    layer.path = mutablePath;
    return mutablePath;
}

#pragma mark **** 设置默认值
- (void)setDefaultProperty {
    
    self.layer.cornerRadius = _width * 0.5;
    self.clipsToBounds = YES;

    // 设置默认值
    _waveHeight = _height;
    _speed = mWATERWAVE_DEFAULT_SPEED;
    _peak = mWATERWAVE_DEFAULT_PEAK;
    _period = mWATERWAVE_DEFAULT_PERIOD;

}

- (void)setPercent:(CGFloat)percent {
    NSAssert(percent >= 0.0f && percent <= 1, @"水波纹完成比例不得小于0或大于1!");
    _percent = percent;
    _changePercent=percent;
}
@end
