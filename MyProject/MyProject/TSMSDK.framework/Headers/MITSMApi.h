#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NPWearable.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 @class MITSMApi
 */
@interface MITSMApi : NSObject


/*! @brief 设置测试环境, default value： NO */
@property (class, assign, nonatomic) BOOL staging;


/*!
 @brief 设置token。
 
 @discussion 使用token之前必须这只token。
 
 @param userID 用户id
 
 @param token accesstoken
 
 @param appID 接入方 appid
 
 */
+ (void)setUserID:(NSString *)userID token:(NSString *)token appID:(NSString *)appID;


/*!
 @brief 初始化手环。
 
 @discussion 调用之前需要实现`NPWearable`协议，初始化过程需要获取手环基本参数靠<NPWearable>提供，初始化为异步初始化
 
 @param wearable 实现<NPWearable>协议的对象
 
 @param completion 初始化完成回调block, 异步
 
 @see NPWearable class
 
 */
+ (void)setWearable:(id<NPWearable>)wearable completion:(void (^)(NSError* _Nullable error))completion;

+ (void)clean;


/*!
 @brief 获取公交卡充值记录
 
 @discussion 获取卡片信息，返回
 
 @param cardName 卡片名称
 
 @param completion 返回回调，回调中返回类型为`NSData`, 其格式为`NPRechargeRecord`对象JSON序列化之后的二进制对象
                   可以使用`NSJSONSerialization`直接解析。
 
 @code
     @interface NPRechargeRecord : NPMurphy
 
     @property (strong, nonatomic) NSString* title;
     @property (strong, nonatomic) NSString* orderId;
     @property (assign, nonatomic) NSInteger amount;
     @property (strong, nonatomic) NSString* statusDesc;
     @property (strong, nonatomic) NSString* time;
     // 1:成功，2:是否可退款，4:是否可重试，8:退款成功
     @property (assign, nonatomic) NSInteger richStatus;
 
     @end
 @endcode
 
 */
+ (void)fetchRechargeRecords:(NSString *)cardName completion:(void (^)(NSData* _Nullable, NSError * _Nullable))completion;

/*!
 @brief 异步获取卡片信息
 
 @discussion 获取卡片信息，返回
 
 @param type 卡片名称
 
 @param completion 返回回调，回调中返回类型为`NSData`, 其格式为`NPAppletInformation`对象JSON序列化之后的二进制对象
 可以使用`NSJSONSerialization`直接解析。
 
 @code
 @interface NPAppletInformation : NSObject
 
 @property (strong, nonatomic) NSString* cardType;
 
 @property (strong, nonatomic) NSString* cardNumber;
 @property (strong, nonatomic) NSString* validStart;
 @property (strong, nonatomic) NSString* validEnd;
 
 @property (readonly, nonatomic) BOOL isValidStartDate;
 @property (readonly, nonatomic) BOOL isValidEndDate;
 
 @property (assign, nonatomic) NSInteger balance;
 @property (assign, nonatomic) NSInteger overdraw;
 
 @property (assign, nonatomic) NSInteger transactionCount;
 @property (strong, nonatomic) NSArray<NPTradeRecord *>* transactionRecords;
 
 // 卡片状态
 @property (assign, nonatomic) BOOL activity;
 
 // 是否在黑名单中.
 @property (assign, nonatomic) BOOL inBlackList;
 
 @end
 @endcode
 
 */
+ (void)fetchAppletInformationWithCardName:(NSString *)type completion:(void (^)(NSData* _Nullable appletInformation))completion;


/*!
 @brief 获取公交卡列表
 
 @param completion 返回回调，回调中返回类型为`NSData`, 其格式为`NPTrafficCard`对象数组JSON序列化之后的二进制对象
 可以使用`NSJSONSerialization`直接解析。
 
 @code
     @interface NPTrafficCard : NSObject
 
     // 卡片名称
     @property (strong, nonatomic) NSString *cardName;
 
     // 卡片类型
     @property (assign, nonatomic) NSInteger cardType;
 
     // 发卡费
     @property (assign, nonatomic) NSInteger issueFee;
 
     // 卡片标题
     @property (strong, nonatomic) NSString *title;
 
     // 卡片子标题
     @property (strong, nonatomic) NSString *subTitle;
 
     // 没开卡时卡片背景图URL
     @property (strong, nonatomic) NSString *preIssuedListBg;
 
     // 开卡后卡片背景图URL
     @property (strong, nonatomic) NSString *issuedListBg;
 
     // 卡片LOGO的URL
     @property (strong, nonatomic) NSString *logo;
 
     // 卡片详情页背景，开卡前用
     @property (strong, nonatomic) NSString *preIssuedDetailBg;
 
     // 卡片详情页背景，开卡后用
     @property (strong, nonatomic) NSString *issuedDetailBg;
 
     // 卡片详情描述
     @property (strong, nonatomic) NSString *detailDesc;
 
     // 卡片状态, 0为可用，1为下线（此时客户端判断手机上是否开通了该卡，如果未开通，则不显示该卡），2为库存不足
     @property (assign, nonatomic) NSInteger status;
 
     // applet实例AID
     @property (strong, nonatomic) NSString *aid;
 
     // 该字段只对公交卡返回，按displayFee升序排列。
     @property (strong, nonatomic) NSArray<NPTrafficCardFee *> *fees;
 
     @end
 
     @interface NPTrafficCardFee : NSObject
 
     // 显示金额
     @property (assign, nonatomic) NSInteger displayFee;
 
     // 支付金额
     @property (assign, nonatomic) NSInteger payFee;
 
     // 充值金额
     @property (assign, nonatomic) NSInteger rechargeFee;
 
     // 描述信息
     @property (strong, nonatomic) NSString* msg;
 
     // 推荐条目标记
     @property (assign, nonatomic) BOOL suggested;
 
     // 收费条目编号，长整型
     @property (assign, nonatomic)  NSInteger feeId;
 
     // 操作类型，1为发卡用，2为充值用
     @property (assign, nonatomic) NSInteger actionType;
 
     // 购买数量
     @property (assign, nonatomic) NSInteger amount;
 
     @end
 @endcode
 
 */
+ (void)fetchCards:(void (^)(NSData* _Nullable cards, NSError * _Nullable error))completion;

/// 获取卡面须知
+ (void)fetchCardNotice:(NSString *)type longitude:(double)longitude latitude:(double)latitude completion:(void (^)(NSArray<NSString *> * _Nullable contents, NSError * _Nullable error))completion;

// 获取用户协议
+ (void)fetchUserProtocolByCardName:(NSString *)cardName completion:(void (^)(NSData* _Nullable userProtocol, NSError* _Nullable error))completion;

// 同意用户协议
+ (void)confirmUserProtocol:(NSInteger)userProtocolID completion:(void (^)(NSData* _Nullable userProtocols, NSError* _Nullable error))completion;

/*!
 @brief 岭南通开卡流程，获取可用城市列表
 
 @discussion SDK会获取定位信息，所以需要确保定位是开启的。
 
 @param cardName 卡片名称
 
 @param completion 返回回调，回调中返回类型为`NSData`, 其格式为`NPCityInfo`对象JSON序列化之后的二进制对象
 可以使用`NSJSONSerialization`直接解析。
 
 @code
 @class NPCity;
 
 @interface NPCityInfo : NSObject
 @property (strong, nonatomic) NPCity* locationCityInfo;
 @property (strong, nonatomic) NPCity* availableCityInfo;
 @end
 
 @interface NPCity : NSObject
 @property (strong, nonatomic) NSString* cityName;
 @property (strong, nonatomic) NSString* cityId;
 @end
 @endcode
 
 */
+ (void)fetchCityInfoWithCardName:(NSString *)cardName completion:(void (^)(NSData* _Nullable cityInfo, NSError* _Nullable error))completion;


/*!
 @brief 创建开卡/充值订单
 
 @param feeId 卡里表中条目id
 
 @param cityId 城市ID
 
 @param completion 返回回调包含订单好，支付信息，NSError
 
 @see createOrderWithFeeId
 
 */
+ (void)createOrderWithFeeId:(NSUInteger)feeId cityId:(NSString *)cityId completion:(void (^)(NSString* _Nullable orderId, NSString* _Nullable payString, NSError * _Nullable error))completion;

+ (void)createOrderWithFeeId:(NSUInteger)feeId completion:(void (^)(NSString* _Nullable orderId, NSString* _Nullable payString, NSError * _Nullable error))completion;


/*!
 @brief 支付订单
 
 @param orderId 订单号
 
 @param completion 返回回调，回调中返回类型为`NSData`, 其格式为`NPOrder`对象数组JSON序列化之后的二进制对象
 可以使用`NSJSONSerialization`直接解析。
 
 @code
 @interface NPOrder : NSObject
 
 // 卡片名称
 @property (strong, nonatomic) NSString* cardName;
 
 // 小米支付订单号
 @property (strong, nonatomic) NSString* orderId;
 
 // 订单状态
 @property (assign, nonatomic) NSInteger orderStatus;
 
 // 支付时间，到epoch的秒数。如果未支付，这个值为0，没意义
 @property (assign, nonatomic) double payTime;
 
 // 用户实际支付的金额，以分为单位
 @property (assign, nonatomic) NSInteger payFee;
 
 // 城市ID
 @property (strong, nonatomic) NSString* cityId;
 
 //
 @property (assign, nonatomic) NSInteger singleCost;
 
 // 原子订单数量，用于日卡.
 @property (assign, nonatomic) NSInteger originCount;
 
 // 剩余未使用的订单数量，用于日卡.
 @property (assign, nonatomic) NSInteger restCount;
 
 // 移卡是否需要收费
 @property (assign, nonatomic) BOOL needPay;
 
 // 只在订单状态是已支付时返回。
 //@property (strong, nonatomic) NPActionToken* actionToken;
 @property (strong, nonatomic) NSArray<NPActionToken *>* actionToken;
 
 @end
 
 @interface NPActionToken : NSObject
 
 // 操作码，由小米定义或 SP 方
 @property (strong, nonatomic) NSString* token;
 
 // 操作类型，1为发卡，2为充值><操作类型
 @property (assign, nonatomic) NPActionTokenType type;
 
 // 充值金额，只在type为2时有这个字段
 @property (assign, nonatomic) NSInteger rechargeAmount;
 
 @end
 @endcode
 
 */
+ (void)payOrder:(NSString *)orderId payString:(NSString *)payString viewController:(UIViewController *)viewController completion:(void (^)(NSData* _Nullable order, NSError * _Nullable error))completion;

/*!
 @brief 设置微信跳转回来的 scheme
 
 @param scheme 微信跳转scheme
 
 */
+ (void)setWeCahtPayScheme:(NSString *)scheme;

/*!
 @brief 退款订单
 
 @param orderId 订单号
 
 @param completion 返回回调，回调中返回类型为`NSData`, 其格式为`NPRefund`对象数组JSON序列化之后的二进制对象
 可以使用`NSJSONSerialization`直接解析。
 
 @code
 @interface NPRefund : NSObject
 
 // 退款是否成功
 @property (assign, nonatomic) BOOL success;
 
 @property (strong, nonatomic)  NSString* responseCode;
 
 @property (strong, nonatomic)  NSString* responseDesc;
 
 @property (assign, nonatomic) NSInteger applyRefundAmount;
 
 @end
 @endcode
 
 */
+ (void)refund:(NSString *)orderId completion:(void (^)(NSData* _Nullable order, NSError * _Nullable error))completion;

/*!
 @brief 根据小米帐号ID查询订单，返回已支付，但对SE的操作未完成的订单
 
 @param completion 返回回调包含订单好，支付信息，NSError
 
 @see payOrder 中的 order
 
 */
+ (void)fetchOrderByUserID:(void (^)(NSData * _Nullable orders, NSError * _Nullable error))completion;


/*!
 @brief 开卡
 
 @param cardName 卡名称
 
 @param token 透传token
 
 @param cityId 城市id
 
 @param completion 异步返回回调
 
 @see `payOrder` `NPActionToken`
 
 */
+ (void)issue:(NSString *)cardName token:(NSString *)token cityId:(NSString *)cityId completion:(void (^)(NSError * _Nullable error))completion;
+ (void)issue:(NSString *)cardName token:(NSString *)token completion:(void (^)(NSError * _Nullable error))completion;



/*!
 @brief 充值
 
 @param cardName 卡名称
 
 @param cardNumber 卡号
 
 @param token 透传token
 
 @param completion 异步返回回调
 
 @see `payOrder` `NPActionToken`
 
 */
+ (void)topup:(NSString *)cardName cardNumber:(NSString *)cardNumber token:(NSString *)token completion:(void (^)(NSError * _Nullable error))completion;

/*!
 @brief 同步
 
 @param cardName 卡名称
 
 @param completion 异步返回回调
 
 */
+ (void)sync:(nullable NSString *)cardName completion:(void (^)(NSError * _Nullable error))completion;

+ (void)sync:(void (^)(NSError * _Nullable error))completion;

/*!
 @brief 检查卡是否为默认卡
 
 @discussion 根据 aid 查询此卡是否被设置成默认卡
 
 @param aid applet实例AID
 
 @see fetchCards aid
 
 */
+ (void)checkActivity:(NSString *)aid completion:(void (^)(BOOL activity))completion;


/*!
 @brief 设置默认卡
 
 @param aid applet实例AID
 
 @see fetchCards aid
 
 */
+ (void)activity:(NSString *)aid completion:(void (^)(BOOL activity))completion;

/*!
 @brief 取消默认卡
 
 @param aid applet实例AID
 
 @see fetchCards aid
 
 */
+ (void)deactivity:(NSString *)aid completion:(void (^)(BOOL activity))completion;

@end

NS_ASSUME_NONNULL_END
