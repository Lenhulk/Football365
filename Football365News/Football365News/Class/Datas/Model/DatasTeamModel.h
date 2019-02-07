//
//  DatasTeamModel.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatasTeamModel : NSObject

typedef void(^CompleteBlock)(NSDictionary *season, NSArray *person, NSDictionary *statistics);

@property (nonatomic, copy) NSString *team_id;
@property (nonatomic, copy) NSString *team_name;
@property (nonatomic, copy) NSString *team_en_name;
@property (nonatomic, copy) NSString *team_logo;
@property (nonatomic, copy) NSString *country_logo;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *founded;
@property (nonatomic, copy) NSString *venue_name;
@property (nonatomic, copy) NSString *venue_capacity;

// 返回 “资料” 内容
- (void)getTeamProfileWithUrlString:(NSString *)url complete:(void(^)(DatasTeamModel *model))completeBlock;

// 返回 “数据” 内容
- (void)getDataWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock;


- (void)code_getMeaFailed;
@end
