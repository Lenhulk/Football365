//
//  ScheduleCell.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//    [self.attentionButton setImage:[UIImage imageNamed:@"Star_Select"] forState:UIControlStateSelected];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 根据FormatString将世界时间的TimeString转换为中国时区的TimeString
- (NSString *)getTimeStringFor:(NSString *)timeString withDateFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeString];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return [dateFormatter stringFromDate:localeDate];
}

#pragma mark - 配置CELL数据
- (void)setModel:(ScheduleModel *)model {
    _model = model;
    UIImage *zhanweiImg = [UIImage imageNamed:@"fbph"];
    
    // 球队信息
    [self.teamA_PicView sd_setImageWithURL:[NSURL URLWithString:model.team_A_logo] placeholderImage:zhanweiImg];
    [self.teamB_picView sd_setImageWithURL:[NSURL URLWithString:model.team_B_logo] placeholderImage:zhanweiImg];
    self.teamA_nameLabel.text = model.team_A_name;
    self.teamB_nameLabel.text = model.team_B_name;
    
    // 比分&事件
    NSString *scoresString = [NSString stringWithFormat:@"%@ - %@",model.fs_A, model.fs_B];
    self.matchScoresLabel.text = scoresString;
    
    NSString *scoresInfo = model.score_info;
    if (![scoresInfo isEqualToString:@""] ) {
        self.matchInfoLabel.text = scoresInfo;
    } else {
        self.matchInfoLabel.text = @"";
    }
    
    //TODO: 比赛状态
    self.matchScoresLabel.hidden = NO;
    self.vsIcon.hidden = YES;
    self.matchInfoLabel.textColor = [UIColor darkGrayColor];
    if ([model.status isEqualToString:@"Played"]) {
        // 完场
    } else if ([model.status isEqualToString:@"Playing"]) {
        // 正在比赛
        self.matchInfoLabel.textColor = [UIColor redColor];
        self.matchInfoLabel.text = [NSString stringWithFormat:@"进行中 %@'", model.playing_time];
    } else {
        // Fixture 未开赛
        self.matchScoresLabel.hidden = YES;
        self.vsIcon.hidden = NO;
    }
    
    // 开赛时间加8小时
    NSString *openHms = [self getTimeStringFor:model.time_utc withDateFormat:@"HH:mm:ss"];
    openHms = [openHms substringToIndex:5];
    self.matchStateLabel.text = [NSString stringWithFormat:@"%@ %@", openHms,  model.match_title];
    
    // 电视台
    if (![model.TVList isEqualToString:@""] ) {
        self.TVLiveLabel.text = model.TVList;
    } else {
        self.TVLiveLabel.text = @"";
    }
}

////日期格式转字符串
//- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:format];
//    NSString *strDate = [dateFormatter stringFromDate:date];
//    return strDate;
//}
//
////字符串转日期格式
//- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:format];
//    
//    NSDate *date = [dateFormatter dateFromString:dateString];
//    return [self worldTimeToChinaTime:date];
//}
//



@end
