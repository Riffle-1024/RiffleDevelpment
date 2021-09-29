//
//  TimerTarget.m
//  MyProject
//
//  Created by mxchip on 2021/9/22.
//

#import "TimerTarget.h"
@interface TimerTarget ()
@property (nonatomic,weak)id target;
@end
@implementation TimerTarget

+(instancetype)timerTarget:(id)target
{
    TimerTarget *timerTarget=[TimerTarget alloc];
    timerTarget.target=target;
    return timerTarget;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    if (!self.target || ![self.target respondsToSelector:sel]) {
        return [NSMethodSignature signatureWithObjCTypes:"v:@"];
    }
    
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if (!self.target) {
        return;
    }
    [invocation invokeWithTarget:self.target];
}

- (void)dealloc
{
    
}
@end
