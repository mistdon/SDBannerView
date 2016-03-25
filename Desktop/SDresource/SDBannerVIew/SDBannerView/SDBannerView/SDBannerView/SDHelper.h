//
//  SDHelper.h
//  SDBannerView
//
//  Created by shendong on 16/3/25.
//  Copyright © 2016年 shendong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDHelper : NSObject

/**
 *  图片缓存路径
 *
 *  @return <#return value description#>
 */
+ (NSString *)cachePath;

/**
 *  将图片保存到本地缓存中
 *
 *  @param identifier url.absoluteString
 *
 *  @return <#return value description#>
 */
+ (BOOL)saveBannerCache:(NSData *)data WithIdentifier:(NSString *)identifier;

/**
 *  取出本地的图片缓存
 *
 *  @param identifier url.absoluteString
 *
 *  @return <#return value description#>
 */

+ (NSData *)getBannerCacheDataWithIdentifier:(NSString *)identifier;

/**
 *  清除轮播图缓存图片
 */
+ (void)clearBannerCache;
@end
