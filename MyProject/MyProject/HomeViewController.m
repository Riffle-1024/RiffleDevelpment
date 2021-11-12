//
//  HomeViewController.m
//  MyProject
//
//  Created by mxchip on 2021/9/10.
//

#import "HomeViewController.h"
#import "MainViewController.h"
#import "MainViewController.h"
#import "UIScrollView+Extend.h"
#import "MJRefresh.h"

static NSInteger kCollectItemNumberOfColumns = 2;
static CGFloat kSpace = 10;
static CGFloat kCollectionItemHeight;
static CGSize kCollectionItemSize;

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,CommonProtocol>

@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong) UITableView * tableView;

@end

@implementation HomeViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        kCollectionItemHeight = (ScreenWidth - (kCollectItemNumberOfColumns + 1) * kSpace) / kCollectItemNumberOfColumns;
        kCollectionItemSize = CGSizeMake(kCollectionItemHeight, kCollectionItemHeight + 65);
    }
    return self;
}
+ (void)load
{
    
//    NSLog(@"[HomeViewController load]");
}

- (void)viewDidLoad {
//    [super viewDidLoad];
    UIButton * nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    [nextBtn addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:nextBtn];
    // Do any additional setup after loading the view.
//    [self showHeaderView];
//    [self.tableView reloadData];
//    [self showCollectionViewHeaderView];
//    [self.collectionView reloadData];
    
//    self.tableView.lyl_newScrollViewDidScrollView = ^(UIScrollView * _Nonnull scrollView) {
//
//    };
    
}


- (void)showHeaderView
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, -250, ScreenWidth, 250)];
    headView.backgroundColor = [UIColor redColor];
    [self.tableView addSubview:headView];
    self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    [self.tableView setContentOffset:CGPointMake(0, -250) animated:NO];
}

- (void)showCollectionViewHeaderView
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, -250, ScreenWidth, 250)];
    headView.backgroundColor = [UIColor yellowColor];
    [self.collectionView addSubview:headView];
    self.collectionView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    [self.collectionView setContentOffset:CGPointMake(0, -250) animated:NO];
    [self.collectionView setContentSize:CGSizeMake(ScreenWidth, 2 * ScreenHeight)];
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollViewStyle = ScrollViewHome;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"下拉刷新");
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            NSLog(@"上拉加载");
        }];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = kCollectionItemSize;
        layout.minimumLineSpacing = kSpace;
        layout.minimumInteritemSpacing = kSpace;
        layout.sectionInset = UIEdgeInsetsMake(kSpace, kSpace, kSpace, kSpace);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"systemCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"systemNilCell"];

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    
    return _collectionView;
}

- (void)homeViewMethod
{
    NSLog(@"[HomeViewController homeViewMethod]");
}

- (void)nextVC
{
    
    MainViewController * homeVC = [[MainViewController alloc] init];
    homeVC.delegate = self;
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
//    if (!cell) {
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
//    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"这是第%ld组，第%ld个",indexPath.section,indexPath.row];
    
    return cell;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 3) {
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"systemCell" forIndexPath:indexPath];;
        
        cell.backgroundColor = [UIColor blueColor];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        titleLabel.text = [NSString stringWithFormat:@"这是第%ld组，第%ld个",indexPath.section,indexPath.row];
        [cell.contentView addSubview:titleLabel];
        return cell;
    }else{
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"systemNilCell" forIndexPath:indexPath];
        return cell;
    }
   

  
   
}

-(void)commonProtocolMethod{
    NSLog(@"commonProtocolMethod");
}

-(NSString *)getClassInstance{
    return NSStringFromClass([self class]);
}

-(void)getDateWithComplete:(void (^)(NSString * _Nonnull))comPlete
{
    comPlete(@"hello");
}
@end
