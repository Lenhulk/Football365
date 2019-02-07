//
//  DatasModel.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/29.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)(NSString *description, NSArray *dataObjs, NSArray *header);

@interface DatasModel : NSObject

//@property (nonatomic , strong , readonly) id object;
// 失球数
@property (nonatomic, strong) NSString *goals_against;
// 进球数
@property (nonatomic, strong) NSString *goals_pro;
// 上赛季排名?
@property (nonatomic, strong) NSString *last_rank;
// 平局数
@property (nonatomic, strong) NSString *matches_draw;
// 负场数
@property (nonatomic, strong) NSString *matches_lost;
// 总场数
@property (nonatomic, strong) NSString *matches_total;
// 胜场数
@property (nonatomic, strong) NSString *matches_won;
// 积分
@property (nonatomic, strong) NSString *points;
// 排名
@property (nonatomic, strong) NSString *rank;
// 队伍id
@property (nonatomic, strong) NSString *team_id;
// 队伍logo
@property (nonatomic, strong) NSString *team_logo;
// 队名
@property (nonatomic, strong) NSString *team_name;


- (void)getModelWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock;


- (void)code_getUserFollouccess;
@end
