//
//  DatasModel.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/29.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "DatasModel.h"

@interface DatasModel ()
//@property (nonatomic , strong) id object;
@end

@implementation DatasModel

- (void)getModelWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock{
    [[WiiNetWorkTool sharedWiiNetWorkTool] requestWithMethod:WiiNetWorkMethodGet URLString:URLString parameters:nil finished:^(id object, NSError *error) {
        NSDictionary *contentDict = [object objectForKey:@"content"];
        NSString *description = contentDict[@"description"];
        NSDictionary *roundContentDict = [contentDict[@"rounds"] firstObject][@"content"];
        NSArray *header = roundContentDict[@"header"];
        NSArray *dataObjs = [NSArray yy_modelArrayWithClass:DatasModel.class json:roundContentDict[@"data"]];
        if (completeBlock) {
            completeBlock(description, dataObjs, header);
        }
        
    }];
}


- (void)code_getUserFollouccess {
    NSLog(@"Continue");
}
@end
