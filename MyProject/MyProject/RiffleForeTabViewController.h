//
//  RiffleForeTabViewController.h
//  MyProject
//
//  Created by liuyalu on 2021/10/13.
//

#import "RiffleTabBarController.h"

NS_ASSUME_NONNULL_BEGIN
@interface RiffleForeTabViewController : RiffleTabBarController<RiffleTabBarControllerDelegate>

-(void)refleshTabBarViewController;
- (void)resetDefaultSelect;

@end

NS_ASSUME_NONNULL_END
