//
//  TeamDataCell.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "TeamDataCell.h"

@interface TeamDataCell()


@end

@implementation TeamDataCell

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.leagueName.text = dict[@"name"];
    self.recordTitle.text = dict[@"record"];
    NSDictionary *matches = dict[@"matches"];
    NSDictionary *fMatches = dict[@"five_matches"];
    self.rankLb.text = [NSString stringWithFormat:@"第%@", dict[@"rank"]];
    self.leagueRecord.text = [NSString stringWithFormat:@"%@胜%@平%@负", matches[@"win"], matches[@"draw"], matches[@"lose"]];
    self.nearFiveRecord.text = [NSString stringWithFormat:@"%@胜%@平%@负", fMatches[@"win"], fMatches[@"draw"], fMatches[@"lose"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)code_checkUserIn {
    NSLog(@"Get User Succrss");
}
@end
