//
//  HTTPRequest.m
//  DouYu
//
//  Created by shendong on 16/5/11.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "HTTPRequest.h"


NSString *const  HTTPCheckUpdate = @"http://capi.douyucdn.cn/api/ios_app/check_update"; 
NSString *const HTTPGetRecommendGameList = @"http://capi.douyucdn.cn/api/app_api/get_app_list?devid=2295CB6B-D6B5-4A7D-AC7B-ED31DAC63205&sign=5cd99ec3c8d3391ca42e93ac97ab17d2&time=1462945493&type=ios";

NSString *const  unknow1 = @"http://capi.douyucdn.cn/api/app_api/get_app_list?devid=2295CB6B-D6B5-4A7D-AC7B-ED31DAC63205&sign=5cd99ec3c8d3391ca42e93ac97ab17d2&time=1462945493&type=ios";
NSString *const  unknow2 = @"http://capi.douyucdn.cn/api/app_api/get_app_list?devid=2295CB6B-D6B5-4A7D-AC7B-ED31DAC63205&sign=5cd99ec3c8d3391ca42e93ac97ab17d2&time=1462945493&type=ios";


@implementation HTTPRequest

+ (void)requestWithUrl:(NSString *)urlString success:(successBlock)successHander fail:(failBlock)failHander{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil] ;
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHander(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failHander(nil, error);
    }];
}

@end
