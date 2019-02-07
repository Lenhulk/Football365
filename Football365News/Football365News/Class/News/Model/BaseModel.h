//
//  HomeModel.h
//  SoccerHoneypot
//
//  Created by Wii on 16/6/20.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)(NSArray *articlesList,NSArray *recommendList,NSString *nextPageUrl);

@interface BaseModel : NSObject

@property (nonatomic , strong , readonly) id object;

// 下一页
@property (nonatomic, strong) NSString * next;
// 页码
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString * prev;
// 首页cell 模型
@property (nonatomic, strong) NSArray * recommend;
//文章
@property (nonatomic, strong) NSArray * articles;
// id
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * label;
// 刷新时间
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;


- (void)getModelWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock;


@end
