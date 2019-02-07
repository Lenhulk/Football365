//
//  HomeCellModel.h
//  SoccerHoneypot
//
//  Created by Wii on 16/6/20.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArticleModel : NSObject

// 发布时间
@property (nonatomic, strong) NSString * published_at;
@property (nonatomic, strong) NSString * scheme;
@property (nonatomic, strong) NSString * share;
@property (nonatomic, strong) NSString * share_title;
// 图片
@property (nonatomic, strong) NSString * thumb;
// 标题
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) BOOL top;
// 链接
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * channel;
// 评论
@property (nonatomic, assign) NSInteger comments_total;
// 具体描述
@property (nonatomic, strong) NSString * descriptionField;
// id
@property (nonatomic, assign) NSInteger idField;
// 文章类型
@property (nonatomic, strong) NSString * label;
// 标题字体颜色
@property (nonatomic, strong) NSString * labelColor;

/**
 *  封面大图
 */
@property (nonatomic , strong) NSDictionary *cover;
/**
 *  圈子
 */
@property (nonatomic , strong) NSDictionary *topic;
@end
