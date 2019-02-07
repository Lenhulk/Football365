//
//  HomeCellModel.m
//  SoccerHoneypot
//
//  Created by Wii on 16/6/20.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"idField" : @"id",
             @"descriptionField" : @"description"};
}

@end
