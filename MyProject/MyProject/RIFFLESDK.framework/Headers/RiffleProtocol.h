//
//  RiffleProtocol.h
//  RiffleFramework
//
//  Created by mxchip on 2021/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RiffleProtocol <NSObject>

@optional

- (void)sendMessage:(NSString *)message;


@required

- (NSString *)getDeviceId;

- (NSString *)getDeviceModel;

- (NSString *)getDeviceSeries;

@end

NS_ASSUME_NONNULL_END
