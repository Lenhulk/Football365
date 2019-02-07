//
//  NewsCell.m
//  SoccerHoneypot
//
//  Created by Wii on 16/6/29.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "NewsCell.h"
#import "TYFBNewsItemPageView.h"
@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (CGFloat)getCellHeigh:(ArticleModel *)articlemodel {
    if (articlemodel.cover) {
        return 230;
    }
    return 100;
}
- (void)setModel:(ArticleModel *)model {
    _model = model;
    if (model.cover) {
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.cover[@"pic"]]];
    } else {
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    }
    self.titleLabel.text = model.title;
    if (!model.descriptionField || [model.descriptionField isEqualToString:@""]) {
        self.titleLabelConstraintH.constant = 50.0;
        self.descriptionLabel.hidden = YES;
    } else {
        self.titleLabelConstraintH.constant = 25.0;
        self.descriptionLabel.hidden = NO;
    }
    if (model.topic) {
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.topic[@"thumb"]]];
        self.createBefromLabel.text = [NSString stringWithFormat:@"%@发布于%@圈",model.topic[@"author"][@"username"],model.topic[@"group"][@"title"]];
    }
    self.descriptionLabel.text = model.descriptionField;
    self.comments_Total.text = [NSString stringWithFormat:@"%ld",self.model.comments_total];
}

+ (NSString *)cellIdentifierForRow:(ArticleModel *)articleModel {
    if (articleModel.cover) {
        return @"NewsCellTow";
    }
    return @"NewsCellOne";
}



- (void)setRecommendArray:(NSArray *)recommendArray {
    _recommendArray = recommendArray;
    NSMutableArray *picArray = [NSMutableArray array];
    NSMutableArray *titleArray = [NSMutableArray array];
    NSMutableArray *urlArray = [NSMutableArray array];
    for (ArticleModel *model in recommendArray) {
        [picArray addObject:model.thumb];
        [titleArray addObject:model.title];
        [urlArray addObject:model.url];
    }
    self.loopScrollView.imageURLStringsGroup = [picArray copy];
    self.loopScrollView.titlesGroup = [titleArray copy];
    self.loopScrollView.autoScrollTimeInterval = 3;
    self.loopScrollView.hidesForSinglePage = YES;
    self.loopScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    self.loopScrollView.pageControlBottomOffset = -20;
    
//    self.loopScrollView.rollTime = 4;
//    self.loopScrollView.images = [picArray copy];
//    self.loopScrollView.describeArray = [titleArray copy];
}
@end
