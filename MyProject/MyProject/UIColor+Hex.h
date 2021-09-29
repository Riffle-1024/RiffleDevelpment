//
//  UIColor+Hex.h
//  DYZhilian
//
//  Created by zhaoxiaoyan on 2017/9/18.
//  Copyright © 2017年 zhaoxiaoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *) colorWithHexString: (NSString *)color;

+ (UIColor *) colorWithHexString: (NSString *)color  alpha:(CGFloat)alpha;
@end
