//
//  CustomeBtn.h
//  MyProject
//
//  Created by mxchip on 2021/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomeBtn : UIView

@property(nonatomic,copy) NSString * title;

- (void)btnClickCallBack:(void(^)(void))complete;

@end

NS_ASSUME_NONNULL_END
