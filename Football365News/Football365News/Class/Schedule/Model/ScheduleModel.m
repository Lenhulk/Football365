//
//  ScheduleModel.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "ScheduleModel.h"

@interface ScheduleModel ()
@property (nonatomic , strong) id object;
@end


@implementation ScheduleModel

- (NSString *)getUpdateToNextDate {
    
    if (self.object) {
        NSDictionary *dict = [self.object copy];
        NSString *urlString = dict[@"nextDate"];
        return urlString;
    }
    return @"";
    
}

- (void)getCellModelDataWithURLString:(NSString *)urlString SectionKeyAndDictionary:(SectionKeyAndDictionary)sectionKeyAndDictionary {
    [[WiiNetWorkTool sharedWiiNetWorkTool] requestWithMethod:WiiNetWorkMethodGet URLString:urlString parameters:nil finished:^(id object, NSError *error) {
        self.object = [object copy];
        NSMutableArray *array = [NSMutableArray array];// date_utc数组
        if (self.object) {
            for (NSDictionary *dict in self.object[@"list"]) {
                ScheduleModel *model = [ScheduleModel yy_modelWithJSON:dict];
                [array addObject:model.date_utc];
            }
        }
        //    array = [array valueForKeyPath:@"@distinctUnionOfObjects.self"];
        NSMutableArray *listAry = [[NSMutableArray alloc]init];
        for (NSString *str in array) {
            if (![listAry containsObject:str]) {
                [listAry addObject:str];
            }
        }
        NSMutableArray *infoArray = [NSMutableArray array];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        for (NSString *str in listAry) {
            for (NSDictionary *dict in self.object[@"list"]) {
                ScheduleModel *model = [ScheduleModel yy_modelWithJSON:dict];
                if ([str isEqualToString:model.date_utc]) {
                    [infoArray addObject:model];
                }
            }
            [dictionary setObject:[infoArray copy] forKey:str];
            [infoArray removeAllObjects];
        }
        if (sectionKeyAndDictionary) {
            sectionKeyAndDictionary([listAry copy],[dictionary copy]);
        }

    }];
}


@end
