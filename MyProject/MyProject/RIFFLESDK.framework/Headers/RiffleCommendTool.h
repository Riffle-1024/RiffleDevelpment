//
//  RiffleCommendTool.h
//  RiffleFramework
//
//  Created by mxchip on 2021/9/15.
//

#import <Foundation/Foundation.h>
@class DeviceModel;

#import "RiffleProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RiffleCommendTool : NSObject


+ (void)setProtocol:(id<RiffleProtocol>)commendTool;

+ (DeviceModel *)getDeviceInfo;

@end

NS_ASSUME_NONNULL_END
