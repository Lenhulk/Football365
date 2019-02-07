//
//  APIMacro.h
//  SoccerHoneypot
//
//  Created by Wii on 16/6/22.
//  Copyright © 2016年 Wii. All rights reserved.
//

#ifndef APIMacro_h
#define APIMacro_h

// 类别分组
#define API_Group @"https://api.dongqiudi.com/app/global/2/iphone.json?version=450"


#pragma mark - 赛事新闻
// 头条
#define API_TopNews @"https://api.dongqiudi.com/app/tabs/iphone/1.json"
// 欧洲杯
#define API_EuropeanCup @"https://api.dongqiudi.com/app/tabs/iphone/84.json"
// 西甲
#define API_LIGABBVA @"https://api.dongqiudi.com/app/tabs/iphone/5.json"
// 英超
#define API_PremierLeague @"https://api.dongqiudi.com/app/tabs/iphone/3.json"
// 德甲
#define API_Bundesliga @"https://api.dongqiudi.com/app/tabs/iphone/6.json"
// 意甲
#define API_SerieA @"https://api.dongqiudi.com/app/tabs/iphone/4.json"
// 废弃： 法甲
#define API_Ligue1 @""
// 中超
#define API_CSL @"https://api.dongqiudi.com/app/tabs/iphone/56.json"
// 转会
#define API_Transfer @"https://api.dongqiudi.com/app/tabs/iphone/83.json"
#pragma mark --文章

//TODO:  评论
#define API_ArticlesComments @"https://api.dongqiudi.com/articles/comments/"


#pragma mark - 比赛数据
// 赛程列表
#define API_Schedule @"https://api.dongqiudi.com/data/tab/new/important?start="
// 赛程内页  main数据
#define API_ScheduleDetail(matchId) [NSString stringWithFormat:@"https://api.dongqiudi.com/data/detail/match/%@?platform=iphone&version=612", matchId]
// 比赛分析  返回URL
#define API_MatchInfo @"https://api.dongqiudi.com/data/pre_analysis/"


#pragma mark - 积分数据
//中超
#define API_CSL_Datas @"https://sport-data.dongqiudi.com/soccer/biz/data/standing?season_id=10219&app=dqd&version=612&platform=ios"
//西甲
#define API_LIGABBVA_Datas @"https://sport-data.dongqiudi.com/soccer/biz/data/standing?season_id=10332&app=dqd&version=612&platform=ios"
//英超
#define API_PremierLeague_Datas @"https://sport-data.dongqiudi.com/soccer/biz/data/standing?season_id=10267&app=dqd&version=612&platform=ios"
//德甲
#define API_Bundesliga_Datas @"https://sport-data.dongqiudi.com/soccer/biz/data/standing?season_id=10294&app=dqd&version=612&platform=ios"
//意甲
#define API_SerieA_Datas @"https://sport-data.dongqiudi.com/soccer/biz/data/standing?season_id=9298&app=dqd&version=612&platform=ios"
//中甲
#define API_CLO_Datas @"https://sport-data.dongqiudi.com/soccer/biz/data/standing?season_id=10227&app=dqd&version=612&platform=ios"

// 队伍数据
#define API_TeamProfile(teamId) [NSString stringWithFormat:@"https://api.dongqiudi.com/data/v1/sample/team/%@", teamId]
// 积分内页
#define API_TeamDetail(teamId) [NSString stringWithFormat:@"https://sport-data.dongqiudi.com/soccer/biz/dqd/team/statistic/%@?lang=zh-cn", teamId]



#endif /* APIMacro_h */



