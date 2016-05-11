//
//  HTTPRequest.h
//  DouYu
//
//  Created by shendong on 16/5/11.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id responseObject);
typedef void(^failBlock) (id failObject, NSError *error);


FOUNDATION_EXPORT NSString *const HTTPCheckUpdate; //检查更新
FOUNDATION_EXPORT NSString *const HTTPGetRecommendGameList;


@interface HTTPRequest : NSObject

+ (void)requestWithUrl:(NSString *)urlString success:(successBlock)successHander fail:(failBlock)failHander;
@end
