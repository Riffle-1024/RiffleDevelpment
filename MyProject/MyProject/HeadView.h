//
//  HeadView.h
//  MyProject
//
//  Created by mxchip on 2021/9/22.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,mCurveType) {
    
    mCurveTypeSin, // 正选
    mCurveTypeCos  // 余弦
};


NS_ASSUME_NONNULL_BEGIN

@interface HeadView : UIView

@property (nonatomic, assign) CGFloat percent;/**<完成比例 DEFAULT:0.0*/
@property (nonatomic, assign) CGFloat speed;  /**<水波纹横向移动的速度 DEFAULT:0.1*/
@property (nonatomic, assign) CGFloat peak;   /**<峰值:水波纹的纵向高度 DEFAULT:6.0*/
@property (nonatomic, assign) CGFloat period; /**<周期数:一定宽度内水波纹的周期个数 DEFAULT:1.2*/

@property (nonatomic, strong) UIColor *firstWaveColor;
@property (nonatomic, strong) UIColor *secondWaveColor;

/**
 开启水波纹动画
 */
- (void)startWave;

/**
 停止
 */
- (void)stopWave;


+ (CGMutablePathRef)pathWithCurveType:(int)type WaveHeight:(CGFloat)_waveHeight
                       ChangePercent:(CGFloat)_changePercent
                              Height:(CGFloat)_height
                              Period:(CGFloat)_period
                               Width:(CGFloat)_width
                                Peak:(CGFloat)_peak
                               OffSet:(CGFloat)_offSet
                                Layer:(CAShapeLayer *)layer;

@end

NS_ASSUME_NONNULL_END
