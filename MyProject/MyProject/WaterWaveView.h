//
//  WaterWaveView.h
//  MyProject
//
//  Created by liuyalu on 2021/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterWaveView : UIView

@property(nonatomic,strong) UIColor * waveColor;//水纹颜色
@property(nonatomic,strong) UIColor * maskColor;//水纹遮罩颜色

@property(nonatomic,assign) CGFloat waveSpeed;//水纹的速度
@property(nonatomic,assign) CGFloat percent; //水深占据整个view的比例
@property(nonatomic,assign) CGFloat peak;    //水纹的纵向高度


//启动水波纹
-(void)startWave;

//停止水波纹
-(void)stopWave;

@end

NS_ASSUME_NONNULL_END
