//
//  AppDelegate.m
//  MyProject
//
//  Created by mxchip on 2021/9/6.
//

#import "AppDelegate.h"
#import "ExceptionManager.h"
#import "AspectsTool.h"
#import <objc/runtime.h>
#import "ViewController.h"
#import "HomeViewController.h"
#import "Aspects.h"
#import "MainViewController.h"

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AppDelegate registerAspectsMethod];
//    [ExceptionManager registerExceptionCallBack];
//    [ViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//
//    }error:nil];
//    [HomeViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//
//    }error:nil];
//    [MainViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
//
//    }error:nil];
    return YES;
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

+ (void)registerAspectsMethod
{
    __weak typeof(self) weakSelf = self;
    //异步线程执行
    dispatch_queue_t queue = dispatch_queue_create("registerAspects.com", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //读取配置文件，获取需要统计的事件列表
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Aspects" ofType:@"plist"];
                NSDictionary *eventStatisticsDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        for (NSString *classNameString in eventStatisticsDict.allKeys) {
               //使用运行时创建类对象
               const char * className = [classNameString UTF8String];
               //从一个字串返回一个类
               Class newClass = objc_getClass(className);
               NSArray *pageEventList = [eventStatisticsDict objectForKey:classNameString];
               for (NSDictionary *eventDict in pageEventList) {
                   //事件方法名称
                   NSString *eventMethodName = eventDict[@"methodName"];
                   SEL seletor = NSSelectorFromString(eventMethodName);
                   NSString *eventId = eventDict[@"eventId"];
                   NSArray *params = eventDict[@"Params"];
                   [AspectsTool trackEventWithClass:newClass selector:seletor event:eventId params:params];
               }
           }
    });
}

@end
