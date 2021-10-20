//
//  RiffleTabBarController.h
//  MyProject
//
//  Created by liuyalu on 2021/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define TAB_BAR_HEIGHT DEVICE_IS_IPHONE_X ? 83.0f : 49.0f

#define DEVICE_IS_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
static const NSInteger TAG_OFFSET = 10000;

@protocol RiffleTabBarControllerDelegate;

@interface RiffleTabBarController : UIViewController {
        UIView *tabButtonsContainerView;
        UIView *contentContainerView;
}

@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) UIViewController *selectedViewController;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL switchAnimated;
@property (nonatomic, retain) id <RiffleTabBarControllerDelegate> delegate;
@property (nonatomic, assign) float tabBarHeight;
@property (nonatomic, retain) NSArray *tabBarImages;
@property (nonatomic, retain) NSArray *tabBarTitles;
@property (nonatomic, retain) UIImage *tabBarBackgroundImage;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)selectedViewController animated:(BOOL)animated;
- (void)tabButtonPressed:(UIButton *)sender;

@end

@protocol RiffleTabBarControllerDelegate <NSObject>
@optional
- (BOOL)mcTabBarController:(RiffleTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
- (void)mcTabBarController:(RiffleTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
