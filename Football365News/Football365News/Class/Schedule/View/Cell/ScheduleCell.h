//
//  ScheduleCell.h
//  SoccerHoneypot
//
//  Created by Wii on 16/7/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"


@interface ScheduleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teamA_PicView;
@property (weak, nonatomic) IBOutlet UILabel *teamA_nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamB_picView;
@property (weak, nonatomic) IBOutlet UILabel *teamB_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *TVLiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchScoresLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vsIcon;

@property (nonatomic , strong) ScheduleModel *model;

@end
