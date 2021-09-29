//
//  UIScrollView+Extend.h
//  PhilipsIos
//
//  Created by mxchip on 2021/9/23.
//  Copyright © 2021 mxchip. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ScrollViewDidScrollView)(UIScrollView *scrollView);

typedef void(^ScrollViewBeginDragginScrollView)(UIScrollView *scrollView);

typedef NS_ENUM(NSInteger, ScrollViewStyle) {
    ScrollViewDefault = 0,
    ScrollViewHome = 1,
};


@interface UIScrollView (Extend)

@property(nonatomic,assign)ScrollViewStyle scrollViewStyle;

@property (nonatomic, copy) ScrollViewDidScrollView lyl_newScrollViewDidScrollView;

@property (nonatomic, copy) ScrollViewBeginDragginScrollView lyl_newScrollViewBeginDragginScrollView;


@end

NS_ASSUME_NONNULL_END
