//
//  SDHelper.m
//  SDBannerView
//
//  Created by shendong on 16/3/25.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import "SDHelper.h"
#import <CommonCrypto/CommonDigest.h>

static NSInteger const KMaxBannerCacheFileCount = 100;

@implementation SDHelper

+ (NSString *)cachePath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"Caches/SDBannerDataCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
+ (NSString *)createDataPathWithString:(NSString *)identifier{
    return [[self cachePath] stringByAppendingPathComponent:[self createMD5StringWithString:identifier]];
}
+ (BOOL)saveBannerCache:(NSData *)data WithIdentifier:(NSString *)identifier {
    NSString *path = [self createDataPathWithString:identifier];
    return [data writeToFile:path atomically:YES];
}
+ (NSData *)getBannerCacheDataWithIdentifier:(NSString *)identifier {
    static BOOL isCheckCacheDisk = NO;
    if (!isCheckCacheDisk) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self cachePath] error:nil];
        if (contents.count > KMaxBannerCacheFileCount) {
            [manager removeItemAtPath:[self cachePath] error:nil];
        }
        isCheckCacheDisk = YES;
    }
    NSString *path = [self createDataPathWithString:identifier];
    NSData *data =[NSData dataWithContentsOfFile:path];
    return data;
}


+ (void)clearBannerCache {
    if (![[NSFileManager defaultManager] removeItemAtPath:[self cachePath] error:nil]) {
        NSLog(@"SDBannerView clear cache data failed");
    };
}
#pragma mark - hash
+ (NSString *)createMD5StringWithString:(NSString *)string{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X",result[i]];
    }
    [hash lowercaseString];
    return hash;
}
@end
