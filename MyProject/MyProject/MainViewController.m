//
//  MainViewController.m
//  MyProject
//
//  Created by mxchip on 2021/9/13.
//

#import "MainViewController.h"
//#import <RIFFLESDK/RIFFLESDK.h>
#import "MyCommondTool.h"

@interface MainViewController ()

@property (nonatomic,strong) MyCommondTool *commondTool;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData:@"hello" other:@"hahhaha"];
    [self creatBtn];
}

- (void)loadData:(NSString *)string other:(NSString *)string2
{
    
}


- (void)creatBtn
{
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    btn1.frame = CGRectMake(100, 100, 100, 30);
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    btn2.frame = CGRectMake(100, 200, 100, 30);
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 addTarget:self action:@selector(btnClick3) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"btn3" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor redColor];
    btn3.frame = CGRectMake(100, 300, 100, 30);
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
}

- (void)btnClick1
{
//    self.commondTool = [[MyCommondTool alloc] init];
//    [RiffleCommendTool setProtocol:self.commondTool];
//    RiffleViewController *riffleVC = [[RiffleViewController alloc] init];
//    [self.navigationController pushViewController:riffleVC animated:YES];
}

- (void)btnClick2
{
    
}

- (void)btnClick3
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
