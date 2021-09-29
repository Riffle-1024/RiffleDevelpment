//
//  AspectsTool.m
//  MyProject
//
//  Created by mxchip on 2021/9/13.
//

#import "AspectsTool.h"
#import "Aspects.h"


@implementation AspectsTool

+ (void)trackEventWithClass:(Class)klass selector:(SEL)selector event:(NSString *)event params:(NSArray *)paramNames
{
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, NSArray *dict) {
        //定义与事件相关的属性信息
        NSMutableDictionary *properties = [NSMutableDictionary dictionary];
        NSLog(@"统计**********%@,dict:%@",event,dict);
        //如果有参数，那么把参数名和参数值拼接在eventID之后
        if (paramNames.count > 0) {
            if ([dict isKindOfClass:[NSDictionary class]]) {
                //获取dict
                for (NSString *paramName in paramNames) {
                    //添加所需参数
//                    NSString *paramValue = [dict objectForKey:paramName];
//                    properties[paramName] = paramValue;
                }
            }
        }

        
    } error:NULL];
}

@end
