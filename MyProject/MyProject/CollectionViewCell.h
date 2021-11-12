//
//  CollectionViewCell.h
//  MyProject
//
//  Created by liuyalu on 2021/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mDetailLabel;

@end

NS_ASSUME_NONNULL_END
