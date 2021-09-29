//
//  ExceptionManager.m
//  MyProject
//
//  Created by mxchip on 2021/9/8.
//

#import "ExceptionManager.h"
#import <UIKit/UIKit.h>
#import "CustomeBtn.h"
#import "ViewController.h"

@interface ExceptionManager()

@property (nonatomic,assign) BOOL dissMiss;

@end

@implementation ExceptionManager

+ (void)registerExceptionCallBack
{
    NSSetUncaughtExceptionHandler(handleExceptionAndTalk);
}

void handleExceptionAndTalk(NSException *exception){
    
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",exception.name,exception.reason,[[exception callStackSymbols] componentsJoinedByString:@"\n"]];
    NSLog(@"errorContent:%@",content);
    //保存异常信息
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    info[@"name"] = [exception name];// 异常名字
    
    info[@"reason"] = [exception reason];// 异常描述（报错理由）
    
    info[@"callStackSymbols"] = [exception callStackSymbols];// 调用栈信息（错误来源于哪个方法）
    
    //写入沙盒
    
    NSString *path =[NSHomeDirectory() stringByAppendingString:@"/crash.plist"];
    
    [info writeToFile:path atomically:YES];
    
    //  把异常崩溃信息发送至开发者邮件
    
    NSMutableString *mailUrl = [NSMutableString string];
    
    [mailUrl appendString:@"937883885@qq.com"];
    
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    
    [mailUrl appendFormat:@"&body=%@", content];
    
    // 打开地址
    
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
    
    __block BOOL dismiss = NO;
    
    //    UIAlertController * alertViewController = [UIAlertController alertControllerWithTitle:@"发生崩溃" message:content preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertAction * action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        dismiss = YES;
    //    }];
    //    [alertViewController addAction:action];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //    [window.rootViewController presentViewController:alertViewController animated:YES completion:^{
    //
    //    }];
    
    
    UIView * showView = [[UIView alloc] initWithFrame:window.bounds];
    [window.rootViewController.view addSubview:showView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60,showView.frame.size.width/2 , 20)];
    titleLabel.text = @"崩溃了";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.textColor = [UIColor redColor];
    [showView addSubview:titleLabel];
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 90, showView.frame.size.width, showView.frame.size.height - 90)];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.text = content;
    [showView addSubview:textView];
    [textView setEditable:NO];
    //    CustomeBtn * customeBtn = [[CustomeBtn alloc] initWithFrame:CGRectMake(showView.frame.size.width/2, 60, showView.frame.size.width/2, 20)];
    //    customeBtn.title = @"复制信息并退出app";
    //    customeBtn.backgroundColor = [UIColor redColor];
    //    [showView addSubview:customeBtn];
    //    [customeBtn btnClickCallBack:^{
    //        //复制信息
    //        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //        pasteboard.string = content;
    //        NSLog(@"复制成功了************************");
    //        dismiss = YES;
    //    }];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(showView.frame.size.width/2, 60, showView.frame.size.width/2, 20);
    btn.backgroundColor = [UIColor redColor];
    ViewController * rootVC = (ViewController *)window.rootViewController;
    [btn addTarget:rootVC action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:btn];
    
    [rootVC viewControllCallBack:^{
        dismiss = YES;
        //复制信息
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = content;
    }];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    while (!dismiss) {
        for (NSString * model in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)model, 0.001, false);
        }
    }
    CFRelease(allModes);
    NSSetUncaughtExceptionHandler(NULL);
    
}



@end
