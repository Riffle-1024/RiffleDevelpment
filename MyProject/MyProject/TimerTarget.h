//
//  TimerTarget.h
//  MyProject
//
//  Created by mxchip on 2021/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerTarget : NSProxy

+(instancetype)timerTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
