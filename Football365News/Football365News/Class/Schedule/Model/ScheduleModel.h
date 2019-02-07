//
//  ScheduleModel.h
//  SoccerHoneypot
//
//  Created by Wii on 16/7/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SectionKeyAndDictionary)(NSArray *keyArray , NSDictionary *dataDictionary);

@interface ScheduleModel : NSObject

@property (nonatomic , strong,readonly) id object;

// ✨关键id
@property (nonatomic, assign) NSInteger competition_id; //"251"
@property (nonatomic, strong) NSString * match_id;      //"50940972"
@property (nonatomic, assign) NSInteger relate_id;      //一般同上
// ✨队伍信息
@property (nonatomic, strong) NSString * team_A_id;    //"50937108"
@property (nonatomic, strong) NSString * team_A_logo;  //"https://img.dongqiudi.com/soccer/data/logo/team/1755.png"
@property (nonatomic, strong) NSString * team_A_name;   //"皇家马德里"
@property (nonatomic, strong) NSString * team_B_id;
@property (nonatomic, strong) NSString * team_B_logo;
@property (nonatomic, strong) NSString * team_B_name;
// ✨可观看直播的频道  " CCTV5,北京体育,五星体育,图文直播"
@property (nonatomic, strong) NSString * TVList;
// ✨赛事全称  “中甲 第16轮”
@property (nonatomic, strong) NSString * match_title;
// 比赛名   “中甲”
@property (nonatomic, strong) NSString * competition_name;
// 场次    “常规赛”
@property (nonatomic, strong) NSString * round_name;
// 比赛完整时间   “90”
@property (nonatomic, strong) NSString * minute;
// ✨正进行到的时间
@property (nonatomic, strong) NSString * playing_time;
// ✨完场比分
@property (nonatomic, strong) NSString * fs_A;
@property (nonatomic, strong) NSString * fs_B;
// 点球比分
@property (nonatomic, strong) NSString * ps_A;
@property (nonatomic, strong) NSString * ps_B;
// 不知道什么比分？
@property (nonatomic, strong) NSString * ets_A;
@property (nonatomic, strong) NSString * ets_B;
// 赛事关键事件  "点球4 - 5 | 两回合7 - 8"
@property (nonatomic, strong) NSString * score_info;
// 数据类型？  "match"
@property (nonatomic, strong) NSString * relate_type;
// 开赛完整时间（模型内时间均为UTC格林尼治时间）   "2018-08-04 22:05:00"
@property (nonatomic, strong) NSString * start_play;
// 开赛时间  "11:35:00"
@property (nonatomic, strong) NSString * time_utc;
// 开赛日
@property (nonatomic, strong) NSString * date_utc;
// 比赛状态："Played","Playing","Fixture"
@property (nonatomic, strong) NSString * status;
// 是否有视频资源
@property (nonatomic, assign) BOOL videoFlag;

// 未知数据：
@property (nonatomic, assign) NSInteger gameweek;   // "16"
@property (nonatomic, strong) NSString * suretime;   // "1"
@property (nonatomic, assign) BOOL webLivingFlag;


- (NSString *)getUpdateToNextDate;
- (void)getCellModelDataWithURLString:(NSString *)urlString SectionKeyAndDictionary:(SectionKeyAndDictionary)sectionKeyAndDictionary;
@end
