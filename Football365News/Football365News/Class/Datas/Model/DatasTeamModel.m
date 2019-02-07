//
//  DatasTeamModel.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "DatasTeamModel.h"

@implementation DatasTeamModel

- (void)getTeamProfileWithUrlString:(NSString *)url complete:(void (^)(DatasTeamModel *))completeBlock{
    
    [[WiiNetWorkTool sharedWiiNetWorkTool] requestWithMethod:WiiNetWorkMethodGet URLString:url parameters:nil finished:^(id object, NSError *error) {
        DatasTeamModel *model = [DatasTeamModel yy_modelWithDictionary:object];
        if (completeBlock) {
            completeBlock(model);
        }
    }];
}

- (void)getDataWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock{
    
    [[WiiNetWorkTool sharedWiiNetWorkTool] requestWithMethod:WiiNetWorkMethodGet URLString:URLString parameters:nil finished:^(id object, NSError *error) {
        
        NSDictionary *season = [object objectForKey:@"season"];
        NSArray *persons = [object objectForKey:@"person"];
        NSDictionary *statistics = [object objectForKey:@"statistics"];
        
        if (completeBlock) {
            completeBlock(season, persons, statistics);
        }
    }];
}


- (void)code_getMeaFailed {
    NSLog(@"Continue");
}
@end
