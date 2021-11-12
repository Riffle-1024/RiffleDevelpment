//
//  MainViewController.h
//  MyProject
//
//  Created by mxchip on 2021/9/13.
//

#import <UIKit/UIKit.h>
#import "CommonProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController
@property (nonatomic,weak) id<CommonProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
