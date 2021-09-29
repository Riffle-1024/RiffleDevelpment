
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GreatBridge : NSObject

@property (class, readonly, nonatomic) NSString* cplc;
@property (class, readonly, nonatomic) NSData* cplcData;

@property (class, readonly, nonatomic) NSString* serial;

@property (class, readonly, nonatomic) NSString* deviceModel;
@property (class, readonly, nonatomic) NSString* lang;
@property (class, readonly, nonatomic) NSString* miuiRomType;
@property (class, readonly, nonatomic) NSString* tsmSDKVersion;


+ (nullable NSData *)send:(NSData *)command;

@end

NS_ASSUME_NONNULL_END
