//
//  HomeModel.m
//  SoccerHoneypot
//
//  Created by Wii on 16/6/20.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "BaseModel.h"
#import "ArticleModel.h"

@interface BaseModel ()
@property (nonatomic , strong) id object;
@end

@implementation BaseModel

- (void)getModelWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock {
    [[WiiNetWorkTool sharedWiiNetWorkTool] requestWithMethod:WiiNetWorkMethodGet URLString:URLString parameters:nil finished:^(id object, NSError *error) {
        self.object = [object copy];
        BaseModel *model = [BaseModel yy_modelWithJSON:self.object];
        NSMutableArray *articlelist = [NSMutableArray array];
        NSMutableArray *recommendList = [NSMutableArray array];
        for (ArticleModel *articleModel in model.articles) {
            [articlelist addObject:articleModel];
        }
        for (ArticleModel *recommendModel in model.recommend) {
            [recommendList addObject:recommendModel];
        }
        if (completeBlock) {
            completeBlock(articlelist.copy,recommendList.copy,model.next);
        }
    }];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"articles" : [ArticleModel class],
             @"recommend" : [ArticleModel class]};
}

@end
