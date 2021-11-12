//
//  ViewController.m
//  MyProject
//
//  Created by mxchip on 2021/9/6.
//

#import "ViewController.h"
#import <dlfcn.h>
#import <libkern/OSAtomic.h>
#include <stdlib.h>
#import "Aspects.h"
#import "HomeViewController.h"
#import "HeadView.h"
#import "UIColor+Hex.h"
#import "RippleView.h"
#import "WaterWaveView.h"
#import <WebKit/WebKit.h>
#import "XibShowView.h"
#import "RiffleCollectionViewController.h"

#define kHexColor(a,b) [UIColor colorWithHexString:a alpha:b]
#define JSMessageName_PrivacyPolicy @"jumpPrivacyPolicy"
#define JSMessageName_Protocol @"jumpUserProtocol"

typedef void(^CallBack) (void);

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property(nonatomic,copy)CallBack callBack;

@property(nonatomic,strong)WKWebView *webView;


@property(nonatomic,copy) NSString * startTime;
@property(nonatomic,copy) NSString * endTime;

@end

@implementation ViewController

+ (void)load
{
    //    NSLog(@"[ViewController load]");
}

-(void)getDateWithComplete:(void(^)(NSString * message))comPlete
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    start : NSLog(@"goto start");
    // Do any additional setup after loading the view.
//    self.startTime = [self getCurrentHourAndMinuteTime];
//    [self moveDiskAmount:7 Object1:@"A" Object2:@"B" Object3:@"C"];
//    self.endTime = [self getCurrentHourAndMinuteTime];
//    double diffentTime = [self getTimeDifferenceWithStartTime:self.startTime andEndTime:self.endTime];
//    NSLog(@"汉诺塔执行时间：%lf秒",diffentTime/1000);
    
//    XibShowView * showView = [[[NSBundle mainBundle] loadNibNamed:@"XibShowView" owner:self options:nil] lastObject];
//    showView.frame  = CGRectMake(10, 200, 300, 400);
//    [self.view addSubview:showView];
//    
//    return;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [nextBtn addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:nextBtn];
    
    // WKWebView 网页加载
//            NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//            NSURL* url = [NSURL fileURLWithPath:path];
//            NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//
//    [self.webView loadRequest:request];
//
    [self.view addSubview:self.webView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"myproject" ofType:@"html" inDirectory:@"Html"];
    NSString * basePath = @"Html";
    NSURL *tmpRoot = [NSURL fileURLWithPath:basePath isDirectory:YES];
     NSURL *pathURL = [NSURL fileURLWithPath:filePath];
      [_webView loadRequest:[NSURLRequest requestWithURL:pathURL]];
//    [self.webView loadFileURL:pathURL allowingReadAccessToURL:tmpRoot];
    
    //    goto start;
    
    //    WaterWaveView * headView = [[WaterWaveView alloc] initWithFrame:CGRectMake(50, 300, 280, 280)];
    //    headView.waveColor=kHexColor(@"398AE5", 1.0);
    //    headView.maskColor=kHexColor(@"398AE5", 0.5);
    //    headView.percent = 0.35;
    //    headView.waveSpeed = 0.05;
    //    headView.peak = 8;
    //    [self.view addSubview:headView];
    //    [headView startWave];
    //
    //    return;
    //    HeadView * headView = [[HeadView alloc] initWithFrame:CGRectMake(50, 300, 280, 280)];
    //    headView.firstWaveColor=kHexColor(@"398AE5", 1.0);
    //    headView.secondWaveColor=kHexColor(@"398AE5", 0.5);
    //    headView.percent = 0.35;
    //    headView.speed = 0.05;
    //    headView.peak = 8;
    //    headView.period=2;
    ////    [self.view addSubview:headView];
    //    [headView startWave];
    
    //    SwiftRippleView * rippleView = [[SwiftRippleView alloc] initWithFrame:CGRectMake(186, 300, 3, 3)];
    //    [self.view addSubview:rippleView];
    
    //    RippleView * rippleView = [[RippleView alloc]initWithFrame:CGRectMake(186, 300, 3, 3)];
    //    [self.view addSubview:rippleView];
    
    //    [ViewController aspect_hookSelector:@selector(loadData) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
    //        NSLog(@"统计了loadData方法");
    //        NSLog(@"😂😂😂Dealloc:---->: %@", NSStringFromClass([aspectInfo.instance class]));
    //    }error:nil];
    
    //    [self performSelector:@selector(expectionTest) withObject:nil afterDelay:3.0];
    //    [self stackViewTest];
    //    [self testMethod];
    //    [self loadData];
    int a = 20;//00010100
    int b = 80;//01010000
    //01000100
    //64+4=68
    //    int b = a<<2;
    //    int c = a | 1;
    //    int d = ~a;
    //    int e = a ^ 1;;
    a ^= b;
    NSLog(@"------:%d",a);
    b = a ^ b;//01000100
    //01010000
    //00010100
    NSLog(@"------:%d",b);
    a = a ^ b;//01000100
    //00010100
    //01010000
    
    //    NSLog(@"------:%d",b);
    //    NSLog(@"------:%d",c);
    //    NSLog(@"------:%d",d);
    //    NSLog(@"------:%d",e);
    NSLog(@"------:%d,%d",a,b);
    short aa = 49;//0000000000110001
    //1111111111001110
    short cc = 0; //1000000000000000
    //0111111111111111
    short dd  = ~cc;
    short bb = ~aa;
    NSLog(@"------:%d",bb);
    NSLog(@"------:%@",[ViewController convertBinarySystemFromDecimalSystem:[NSString stringWithFormat:@"%d",cc]]);
    int ee = 1 << 4;
    NSLog(@"------:%d",ee);
    
    void(^block)(NSString * string) = ^(NSString *string){
        
    };
    
}



#pragma mark 十进制转二进制
+ (NSString *)convertBinarySystemFromDecimalSystem:(NSString *)decimal
{
    NSInteger num = [decimal intValue];
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true){
        
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%ld",remainder];
        
        if (divisor == 0){
            
            break;
        }
    }
    
    NSString * result = @"";
    
    for (NSInteger i = prepare.length - 1; i >= 0; i --){
        
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}
- (void)nextVC
{
    
//        HomeViewController * homeVC = [[HomeViewController alloc] init];
//        [self.navigationController pushViewController:homeVC animated:YES];
//        MessageViewController * messageVC = [[MessageViewController alloc] init];
//        [self.navigationController pushViewController:messageVC animated:YES];
//    RiffleCollectionViewController * vc = [[RiffleCollectionViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    SwiftCollectionViewController * collectionVC = [[SwiftCollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionVC animated:YES];
    // 1. webview调用JS函数, JS代码可根据需要拼接好。
    // 此处是设置需要调用的js方法以及将对应的参数传入，需要以字符串的形式
    // 带参数
//    NSString *jsFounction = [NSString stringWithFormat:@"callJS('%@')", @"UserProtocol"];
    // 不带参数
    //    NSString *jsFounction = [NSString stringWithFormat:@"jumpUserProtocol()"];
    // 调用API方法
//    [self.webView evaluateJavaScript:jsFounction completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"evaluateJavaScript:\n result = %@ error = %@",result, error);
//        }else{
//            NSLog(@"调用成功");
//        }
//    }];
}
- (void)expectionTest
{
    NSArray * myArray = @[@"11111",@"222",@"3333",@"444"];
    
    //    for (int i = 0; i <= myArray.count ; i++) {
    //        NSString * string = [myArray objectAtIndex:i];
    //        NSLog(@"string:%@",string);
    //    }
    @try {
        NSString * string = [myArray objectAtIndex:4];
        NSLog(@"string:%@",string);
    } @catch (NSException *exception) {
        NSLog(@"exception%@",exception);
    } @finally {
        NSLog(@"不做任何处理");
        return;
    }
}


- (void)stackViewTest
{
    //    NSArray <UIColor *> *colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor purpleColor],[UIColor greenColor],[UIColor orangeColor]];
    //    UIStackView * stackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 360)];
    //    stackView.backgroundColor = [UIColor cyanColor];
    //    [self.view addSubview:stackView];
    //    int count = 150;
    //    for (int i = 0; i < count ; i++) {
    //
    //        CGFloat width = (self.view.frame.size.width/((count + 1)/3.0f + count));
    //        CGFloat space = width/3.0f;
    ////        UIColor * groundColor = [colorArray objectAtIndex:i%colorArray.count];
    //        int x = arc4random() % 255;
    //        int y = arc4random() % 255;
    //        int z = arc4random() % 255;
    //        UIColor * groundColor = [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:1];
    //        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(space + (space + width) * i, 20, width, 320)];
    //        view.backgroundColor = groundColor;
    //        [stackView addSubview:view];
    //    }


    
    
}


- (void)loadData
{
    NSLog(@"%s",__func__);
}

- (void)testMethod
{
    //    NSLog(@"%s",__func__);
}

- (void)btnClicked
{
    self.callBack();
    NSLog(@"%s",__func__);
}


- (void)viewControllCallBack:(void(^)(void))comPlete
{
    self.callBack = comPlete;
}

//原子队列
static OSQueueHead symboList = OS_ATOMIC_QUEUE_INIT;
//定义符号结构体
typedef struct{
    void * pc;
    void * next;
}SymbolNode;

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableArray<NSString *> * symbolNames = [NSMutableArray array];
    //遍历出队
    while (true) {
        //offset 通过next指针在结构体的偏移量，进而知道next的指向
        //offsetof 就是针对某个结构体找到某个属性相对这个结构体的偏移量
        // offsetof(SymbolNode, next) 可以替换为 8
        SymbolNode * node = OSAtomicDequeue(&symboList, offsetof(SymbolNode, next));
        if (node == NULL) break;
        Dl_info info;
        dladdr(node->pc, &info);
        
        NSString * name = @(info.dli_sname);
        
        // 添加 _
        BOOL isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["];
        NSString * symbolName = isObjc ? name : [@"_" stringByAppendingString:name];
        
        //去重
        if (![symbolNames containsObject:symbolName]) {
            [symbolNames addObject:symbolName];
        }
    }
    
    //取反
    NSArray * symbolAry = [[symbolNames reverseObjectEnumerator] allObjects];
    NSLog(@"%@",symbolAry);
    
    //将结果写入到文件
    NSString * funcString = [symbolAry componentsJoinedByString:@"\n"];
    NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Myproject.order"];
    NSData * fileContents = [funcString dataUsingEncoding:NSUTF8StringEncoding];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
    if (result) {
        NSLog(@"%@",filePath);
    }else{
        NSLog(@"文件写入出错");
    }
}




void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                         uint32_t *stop) {
    static uint64_t N;  // Counter for the guards.
    if (start == stop || *start) return;  // Initialize only once.
    //  printf("INIT: %p %p\n", start, stop);
    for (uint32_t *x = start; x < stop; x++)
        *x = ++N;  // Guards should start from 1.
}

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    //  if (!*guard) return;  // Duplicate the guard check.
    
    void *PC = __builtin_return_address(0);
    
    SymbolNode * node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){PC,NULL};
    
    //入队
    // offsetof 用在这里是为了入队添加下一个节点找到 前一个节点next指针的位置
    OSAtomicEnqueue(&symboList, node, offsetof(SymbolNode, next));
    
    Dl_info info;
    dladdr(PC, &info);
    
    printf("\nfname：%s \nfbase：%p \nsname：%s\nsaddr：%p \n",info.dli_fname,info.dli_fbase,info.dli_sname,info.dli_saddr);
    char PcDescr[1024];
    //__sanitizer_symbolize_pc(PC, "%p %F %L", PcDescr, sizeof(PcDescr));
    //  printf("guard: %p %x PC %s\n", guard, *guard, PcDescr);
}

#pragma mark ========= lazy load =========
-(WKWebView *)webView {
    if (!_webView) {
        // 2. 网页JS调原生:
        //   1> 需要先设置 Webview.configuration 的 userContentController
        //   2> 注册方法名 [wkUController addScriptMessageHandler:self name:];
        //   3> 遵守协议<WKScriptMessageHandler>，实现其方法.
        //   4> 在控制器销毁时，需要移除方法名注册
        
        /*! 设置网页的配置文件 */
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        /*! 允许视频播放 */
        configuration.allowsAirPlayForMediaPlayback = YES;
        /*! 允许在线播放 */
        configuration.allowsInlineMediaPlayback = YES;
        /*! 允许可以与网页交互，选择视图 */
        configuration.selectionGranularity = YES;
        /*! web内容处理池 */
        configuration.processPool = [[WKProcessPool alloc] init];
        /*! 自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作) */
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        /*! 自适应屏幕宽度,注入js */
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width,user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta); var lastDiv = document.createElement('div');lastDiv.id = 'last-div'; document.getElementsByTagName('body')[0].appendChild(lastDiv)";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [wkUController addUserScript:wkUserScript];
        /*! 允许用户更改网页的设置 */
        configuration.userContentController = wkUController;
        //JS调用OC 添加处理脚本
        [wkUController addScriptMessageHandler:self name:JSMessageName_Protocol];
        [wkUController addScriptMessageHandler:self name:JSMessageName_PrivacyPolicy];
        
        // 进行偏好设置
        //        WKPreferences *preferences = [WKPreferences new];
        //        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        //        preferences.minimumFontSize = 40.0;
        //        configuration.preferences = preferences;
        
        CGRect frame = CGRectMake(0, 200, 375,400);
        _webView = [[WKWebView alloc] initWithFrame:frame configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.backgroundColor = [UIColor orangeColor];
    }
    return _webView;
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:JSMessageName_Protocol]) {
        NSLog(@"********用户协议********");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户协议js传递过来的参数"message:[NSString stringWithFormat:@"方法名：%@\n\n参数：%@",message.name,message.body] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [[[UIApplication sharedApplication] windows].firstObject.rootViewController presentViewController:alertController animated:YES completion:^{
            
        }];
    }else if ([message.name isEqualToString:JSMessageName_PrivacyPolicy]){
        NSLog(@"********隐私政策********");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"隐私政策js传递过来的参数"message:[NSString stringWithFormat:@"方法名：%@\n\n参数：%@",message.name,message.body] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [[[UIApplication sharedApplication] windows].firstObject.rootViewController presentViewController:alertController animated:YES completion:^{
            
        }];
    }
}



-(void)moveDiskAmount:(NSInteger )amount Object1:(NSString *)object1 Object2:(NSString *)object2 Object3:(NSString *)object3{
    if (amount == 1) {
        [self moveOject1:object1 toObject3:object3];
    }else{
        [self moveDiskAmount:amount - 1 Object1:object1 Object2:object3 Object3:object2];
        [self moveOject1:object1 toObject3:object3];
        [self moveDiskAmount:amount - 1 Object1:object2 Object2:object1 Object3:object3];
    }
}

-(void)moveOject1:(NSString *)object1 toObject3:(NSString *)object3{
    NSLog(@"%@——>%@",object1,object3);
}

//获取当前时间
-(NSString * )getCurrentHourAndMinuteTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置想要的格式，hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSDate *dateNow = [NSDate date];
    //把NSDate按formatter格式转成NSString
    NSString *currentTime = [formatter stringFromDate:dateNow];
    return currentTime;
    
}

//获取两个时间点的时间差，精确到毫秒
-(double )getTimeDifferenceWithStartTime:(NSString * )startTime andEndTime:(NSString *)endTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSDate* startTimeData = [dateFormatter dateFromString:startTime];
    NSTimeInterval startTimeSp=[startTimeData timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSDate* endTimeData = [dateFormatter dateFromString:endTime];
    NSTimeInterval endTimeSp=[endTimeData timeIntervalSince1970]*1000;
    double difference = (endTimeSp - startTimeSp);
    //    self.serviceTotalTime += difference/1000;//云端时间
    //    NSString * differenceStr = [NSString stringWithFormat:@"%.3f",difference/1000];
    NSLog(@"开始时间：%@，结束时间：%@",startTime,endTime);
    return difference;
    
}
@end
