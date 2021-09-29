//
//  ViewController.h
//  MyProject
//
//  Created by mxchip on 2021/9/6.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)viewControllCallBack:(void(^)(void))comPlete;

- (void)loadData;

@end

