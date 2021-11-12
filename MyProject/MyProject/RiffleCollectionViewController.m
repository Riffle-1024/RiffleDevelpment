//
//  RiffleCollectionViewController.m
//  MyProject
//
//  Created by liuyalu on 2021/11/4.
//

#import "RiffleCollectionViewController.h"
#import "CollectionViewCell.h"



@interface RiffleCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>



@property(nonatomic,strong) UICollectionView * collectionView;

@end



@implementation RiffleCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView reloadData];
}

-(void)createCollectionView{
    
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        //设置每一个cell的宽高
        layout.itemSize = CGSizeMake((ScreenWidth-30)/3, 30);
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
    cell.mTitleLabel.text = [NSString stringWithFormat:@"第%ld组，第%ld个",(long)indexPath.section,(long)indexPath.row];
    return cell;
}
@end


