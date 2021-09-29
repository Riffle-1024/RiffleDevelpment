//
//  UIScrollView+Extend.m
//  PhilipsIos
//
//  Created by mxchip on 2021/9/23.
//  Copyright © 2021 mxchip. All rights reserved.
//

#import "UIScrollView+Extend.h"
#import <objc/runtime.h>

static char * styleKey = "style";

@implementation UIScrollView (Extend)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSSelectorFromString(@"_notifyDidScroll") withMethod:@selector(lyl_scrollViewDidScrollView)];
        
        
        [self swizzleInstanceMethod:NSSelectorFromString(@"_scrollViewWillBeginDragging") withMethod:@selector(lyl_scrollViewWillBeginDragging)];
        
        
    });
}
- (void)lyl_scrollViewDidScrollView {
    [self lyl_scrollViewDidScrollView];
    if (self.scrollViewStyle && self.lyl_newScrollViewDidScrollView) {
        self.lyl_newScrollViewDidScrollView(self);
    }
}

- (void)lyl_scrollViewWillBeginDragging {
    
    [self lyl_scrollViewWillBeginDragging];
    if (self.scrollViewStyle && self.lyl_newScrollViewBeginDragginScrollView) {
        self.lyl_newScrollViewBeginDragginScrollView(self);
    }
    
}
- (void)setLyl_newScrollViewDidScrollView:(ScrollViewDidScrollView)lyl_newScrollViewDidScrollView {
    objc_setAssociatedObject(self, @selector(lyl_newScrollViewDidScrollView), lyl_newScrollViewDidScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ScrollViewDidScrollView)lyl_newScrollViewDidScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLyl_newScrollViewBeginDragginScrollView:(ScrollViewBeginDragginScrollView)lyl_newScrollViewBeginDragginScrollView {
    objc_setAssociatedObject(self, @selector(lyl_newScrollViewBeginDragginScrollView), lyl_newScrollViewBeginDragginScrollView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ScrollViewBeginDragginScrollView)lyl_newScrollViewBeginDragginScrollView {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setScrollViewStyle:(ScrollViewStyle)scrollViewStyle
{
    objc_setAssociatedObject(self, styleKey, [NSNumber numberWithInteger:scrollViewStyle], OBJC_ASSOCIATION_ASSIGN);
}

-(ScrollViewStyle )scrollViewStyle
{
    NSLog(@"[objc_getAssociatedObject(self, styleKey) integerValue]:%ld",(long)[objc_getAssociatedObject(self, styleKey) integerValue]);
    return [objc_getAssociatedObject(self, styleKey) integerValue];
}


#pragma amrk - Swizzle
+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        class_replaceMethod(cls,
                            newSelector,
                            class_replaceMethod(cls,
                                                origSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}
@end
