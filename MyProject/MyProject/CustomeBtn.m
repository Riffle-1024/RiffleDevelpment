//
//  CustomeBtn.m
//  MyProject
//
//  Created by mxchip on 2021/9/8.
//

#import "CustomeBtn.h"

typedef void(^ClickBlock)(void);

@interface CustomeBtn ()

@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,copy) ClickBlock clickBlock;



@end

@implementation CustomeBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self layoutSubview];
    }
    return self;
}


- (void)layoutSubview
{
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:window.rootViewController action:@selector(tapClick:)];
    [self.titleLabel addGestureRecognizer:tap];
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (void)btnClickCallBack:(void(^)(void))complete
{
    self.clickBlock = complete;
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    self.clickBlock();
}
@end
