//
//  CommonProtocol.h
//  MyProject
//
//  Created by liuyalu on 2021/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CommonProtocol <NSObject>

-(void)commonProtocolMethod;

-(NSString *)getClassInstance;

-(void)getDateWithComplete:(void(^)(NSString * message))comPlete;


@end

NS_ASSUME_NONNULL_END
