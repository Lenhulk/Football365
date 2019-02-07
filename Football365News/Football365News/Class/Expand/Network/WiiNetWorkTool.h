//
//  WiiNetWorkTool.h
//  SoccerHoneypot
//
//  Created by Wii on 16/7/7.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


/**
 
 请求方式枚举
 
 */

typedef enum : NSUInteger {
    WiiNetWorkMethodGet = 0,
    WiiNetWorkMethodPost
} WiiNetWorkMethod;

/**
 *  请求回调
 *
 *  @param object 返回的JSON对象
 *  @param error  错误信息
 */

typedef void(^FinishedBlock)(id object,NSError *error);

@interface WiiNetWorkTool : AFHTTPSessionManager

+ (instancetype)sharedWiiNetWorkTool;
- (void)requestWithMethod:(WiiNetWorkMethod)method URLString:(NSString *)URLString parameters:(id)parameters finished:(FinishedBlock)finished;
@end
