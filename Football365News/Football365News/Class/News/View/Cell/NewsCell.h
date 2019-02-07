//
//  NewsCell.h
//  SoccerHoneypot
//
//  Created by Wii on 16/6/29.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
#import "SDCycleScrollView.h"
@interface NewsCell : UITableViewCell
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *picView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
/**
 *  评论数
 */
@property (weak, nonatomic) IBOutlet UILabel *comments_Total;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelConstraintH;

@property (weak, nonatomic) IBOutlet UILabel *createBefromLabel;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *loopScrollView;


@property (nonatomic , strong) ArticleModel *model;
@property (nonatomic , strong) NSArray *recommendArray;


+ (NSString *)cellIdentifierForRow:(ArticleModel *)threeModel;
+ (CGFloat)getCellHeigh:(ArticleModel *)articlemodel;
@end
