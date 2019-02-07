//
//  DatasCell.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/29.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "DatasCell.h"
#import "DatasModel.h"
#import <UIImageView+WebCache.h>

@interface DatasCell()
@property (weak, nonatomic) IBOutlet UILabel *rankLb;
@property (weak, nonatomic) IBOutlet UIImageView *logoLb;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;
@property (weak, nonatomic) IBOutlet UILabel *wonLb;
@property (weak, nonatomic) IBOutlet UILabel *drawLb;
@property (weak, nonatomic) IBOutlet UILabel *lostLb;
@property (weak, nonatomic) IBOutlet UILabel *proAndAgainstLb;
@property (weak, nonatomic) IBOutlet UILabel *pointsLb;

@end

@implementation DatasCell

- (void)setModel:(DatasModel *)model{
    _model = model;
    _rankLb.text = model.rank;
    [_logoLb sd_setImageWithURL:[NSURL URLWithString:model.team_logo]];
    _nameLb.text = model.team_name;
    _totalLb.text = model.matches_total;
    _wonLb.text = model.matches_won;
    _lostLb.text = model.matches_lost;
    _drawLb.text = model.matches_draw;
    _pointsLb.text = model.points;
    _proAndAgainstLb.text = [NSString stringWithFormat:@"%@/%@", model.goals_pro, model.goals_against];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)code_getMediata:(NSString *)string {
    NSLog(@"Get Info Success");
}
@end
