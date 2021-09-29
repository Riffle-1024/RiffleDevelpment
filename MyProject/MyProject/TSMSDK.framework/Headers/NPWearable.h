#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NPWearable

@required

/*!
 @brief 用于SDK获取手环的model
 */
@property (readonly, nonatomic) NSString* model;

/*!
 @brief 用于SDK获取手环的版本
 */
@property (readonly, nonatomic) NSString* version;

/*!
 @brief 用于SDK获取手环序列号
 */
@property (readonly, nonatomic) NSString* serial;

/*!
 @brief 打开手环
 */
- (BOOL)open;

/*!
 @brief 执行APDU指令
 */
- (nullable NSData *)transmit:(NSData *)command;

/*!
 @brief 关闭手环
 */
- (void)close;

/*!
 @brief 需要返回手环的打开状态，如果返回 `YES`，SDK不会执行打开手环操作
 */
@optional
@property (readonly, nonatomic) BOOL opened;

@end

NS_ASSUME_NONNULL_END
