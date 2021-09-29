//
//  AspectsTool.h
//  MyProject
//
//  Created by mxchip on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AspectsTool : NSObject

+ (void)trackEventWithClass:(Class)klass selector:(SEL)selector event:(NSString *)event params:(NSArray *)paramNames;

@end

NS_ASSUME_NONNULL_END
