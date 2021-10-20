//
//  RiffleDownManager.m
//  MyProject
//
//  Created by liuyalu on 2021/10/19.
//

#import "RiffleDownManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "ZipArchive.h"

@implementation RiffleDownManager

-(void)downLoadZipWithUrl:(NSString *)urlString DeviceKey:(NSString *)deviceKey
{
    NSURL * downUrl = [NSURL URLWithString:urlString];
    NSString * md5Name = [self md5:deviceKey DeviceKey:deviceKey];
    NSArray * pathes = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * path = [pathes objectAtIndex:0];//大文件放在沙盒下的Library/Caches
    NSString * finishPath = [NSString stringWithFormat:@"%@/zipDownload/%@",path,md5Name];//保存解压后文件的文件夹路径
    NSString * zipPath = [NSString stringWithFormat:@"%@/%@.zip",path,md5Name];//下载的zip包存放路径
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:finishPath];
    if (!isExist) {//本地不存在文件，下载
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        dispatch_async(queue, ^{
            NSError * error = nil;
            NSData * data = [NSData dataWithContentsOfURL:downUrl options:0 error:&error];
            if (!error) {
                [data writeToFile:zipPath options:0 error:nil];
                //解压zip文件
                ZipArchive * zip = [[ZipArchive alloc] init];
                if ([zip UnzipOpenFile:zipPath]) {//将解压缩的内容写到缓存目录中
                    BOOL success = [zip UnzipFileTo:finishPath overWrite:YES];
                    if (!success) {
                        [zip UnzipCloseFile];
                    }
                    //解压完成  删除压缩包
                    [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
                    
                }
            }
            //存
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:md5Name forKey:md5Name];
            [defaults synchronize];
            
            
        });
        
    }else{
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:md5Name forKey:md5Name];
        [defaults synchronize];
    }
}


- (NSString *)md5:(NSString *)Str DeviceKey:(NSString *)deviceKey
{
    NSString* str=[NSString stringWithFormat:@"mxchip_html_%@_%@",deviceKey,Str];
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
    return  output;
}
-(void)test
{
    NSObject * obj = [NSObject new];

//    objc_sendMsg(obj,@selector(cmd));
}
@end
