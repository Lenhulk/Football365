//
//  WiiNetWorkTool.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/7.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "WiiNetWorkTool.h"

static NSString *const BaseURL = @"";

@protocol WiiNetWorkToolProxy <NSObject>

@optional

/**
 *  AFN 内部的数据访问方法
 *
 *  @param method           HTTP
 *  @param URLString        URLString (请求的URL)
 *  @param parameters       请求的参数
 *  @param uploadProgress   上传进度
 *  @param downloadProgress 下载进度
 *  @param success          请求成功回调
 *  @param failure          请求失败回调
 *
 *  @return NSURLSessionDataTask
 */

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface WiiNetWorkTool() <WiiNetWorkToolProxy>

@end

@implementation WiiNetWorkTool

+ (instancetype)sharedWiiNetWorkTool {
    
    static WiiNetWorkTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]initWithBaseURL:[NSURL URLWithString:BaseURL]];
    });
    
    return instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
        [self.reachabilityManager startMonitoring];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];
    }
    
    return self;
}

/**
 *  网络请求方法
 *
 *  @param method     GET/POST
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param finished   请求结束回调
 */

- (void)requestWithMethod:(WiiNetWorkMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(FinishedBlock)finished {
    URLString = URLString == nil ? @"" : URLString;
    NSString *requestMethod = (method == WiiNetWorkMethodGet) ? @"GET" : @"POST";
    [[self dataTaskWithHTTPMethod:requestMethod URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id obj) {
        finished(obj,nil);
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        finished(nil,error);
    }] resume];
}

@end
