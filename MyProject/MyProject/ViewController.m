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

#define kHexColor(a,b) [UIColor colorWithHexString:a alpha:b]

typedef void(^CallBack) (void);

@interface ViewController ()

@property(nonatomic,copy)CallBack callBack;



@end

@implementation ViewController

+ (void)load
{
    //    NSLog(@"[ViewController load]");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    start : NSLog(@"goto start");
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton * nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [nextBtn addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:nextBtn];
//    goto start;
    return;
    HeadView * headView = [[HeadView alloc] initWithFrame:CGRectMake(50, 300, 280, 280)];
    headView.firstWaveColor=kHexColor(@"398AE5", 1.0);
    headView.secondWaveColor=kHexColor(@"398AE5", 0.5);
    headView.percent = 0.35;
    headView.speed = 0.05;
    headView.peak = 8;
    headView.period=2;
//    [self.view addSubview:headView];
    [headView startWave];
    
    
    
    RippleView * rippleView = [[RippleView alloc]initWithFrame:CGRectMake(186, 300, 3, 3)];
    [self.view addSubview:rippleView];
   
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
    
//    HomeViewController * homeVC = [[HomeViewController alloc] init];
//    [self.navigationController pushViewController:homeVC animated:YES];
    MessageViewController * messageVC = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
    /**
     Cycle inside MyProject; building could produce unreliable results. This usually can be resolved by moving the target's Headers build phase before Compile Sources.
     Cycle details:
     → Target 'MyProject': CodeSign /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app
     ○ Target 'MyProject' has process command with output '/Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app/Info.plist'
     ○ Target 'MyProject' has compile command with input '/Users/mxchip/Desktop/MyProject/MyProject/Base.lproj/LaunchScreen.storyboard'
     ○ Target 'MyProject' has compile command with input '/Users/mxchip/Desktop/MyProject/MyProject/AppDelegate.m'
     ○ Target 'MyProject' has compile command for Swift source files
     ○ Target 'MyProject' has copy command from '/Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/MyProject-Swift.h' to '/Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/DerivedSources/MyProject-Swift.h'
     ○ Target 'MyProject' has compile command for Swift source files


     Raw dependency cycle trace:

     target:  ->

     node: <all> ->

     command: <all> ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app/_CodeSignature ->

     command: target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b-:Debug:CodeSign /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app/Info.plist/ ->

     directoryTreeSignature: � ->

     directoryContents: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app/Info.plist ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app/Info.plist ->

     command: target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b-:Debug:ProcessInfoPlistFile /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Products/Debug-iphonesimulator/MyProject.app/Info.plist /Users/mxchip/Desktop/MyProject/MyProject/Info.plist ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Base.lproj/LaunchScreen-SBPartialInfo.plist ->

     command: target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b-:Debug:CompileStoryboard /Users/mxchip/Desktop/MyProject/MyProject/Base.lproj/LaunchScreen.storyboard ->

     node: <target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b--phase1-compile-sources> ->

     command: Gate target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b--phase1-compile-sources ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/AppDelegate.o ->

     command: target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b-:Debug:CompileC /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/AppDelegate.o /Users/mxchip/Desktop/MyProject/MyProject/AppDelegate.m normal x86_64 objective-c com.apple.compilers.llvm.clang.1_0.compiler ->

     node: <target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b--generated-headers> ->

     command: Gate target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b--generated-headers ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/SwiftHeader.o ->

     command: target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b-:Debug:CompileSwiftSources normal x86_64 com.apple.xcode.tools.swift.compiler ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/DerivedSources/MyProject-Swift.h ->

     command: target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b-:Debug:PBXCp /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/MyProject-Swift.h /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/DerivedSources/MyProject-Swift.h ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/MyProject-Swift.h/ ->

     directoryTreeSignature: � ->

     directoryContents: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/MyProject-Swift.h ->

     node: /Users/mxchip/Library/Developer/Xcode/DerivedData/MyProject-abwfybsutrdqwaalkidepzcuqhov/Build/Intermediates.noindex/MyProject.build/Debug-iphonesimulator/MyProject.build/Objects-normal/x86_64/MyProject-Swift.h ->

     command: target-MyProject-d291bcd95454aaa54df42886e5a2b0f423b975d5d15c050b3bf5613f8d3cd56b-:Debug:CompileSwiftSources normal x86_64 com.apple.xcode.tools.swift.compiler
     */
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



@end
