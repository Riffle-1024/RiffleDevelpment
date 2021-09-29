#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const NPHTTPClientErrorDomain;
FOUNDATION_EXTERN const NSInteger NPHTTPClientErrorCodeSuccessed;

FOUNDATION_EXTERN const NSInteger NPRPCResultOk;

FOUNDATION_EXTERN id NPHTTPClientParseJSON(NSData* data, NSError** error);

@interface NPHTTPClient : NSObject

+ (instancetype)client NS_SWIFT_NAME(client());

- (void)POST:(NSString *)URLString parameters:(nullable NSDictionary *)parameters completion:(void (^)(id _Nullable responseObject, NSError * _Nullable error))completion;

- (void)GET:(NSString *)api parameters:(nullable NSDictionary *)parameters completion:(void (^)(id _Nullable responseObject, NSError * _Nullable error))completion;

- (void)RPCPOST:(NSString *)api parameters:(nullable NSDictionary *)parameters completion:(void (^)(NSData* _Nullable responseObject, NSError * _Nullable error))completion;

- (void)RPCGET:(NSString *)api parameters:(nullable NSDictionary *)parameters completion:(void (^)(NSData* _Nullable responseObject, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
