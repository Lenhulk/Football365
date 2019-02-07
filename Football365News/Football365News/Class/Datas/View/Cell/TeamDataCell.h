//
//  TeamDataCell.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamDataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leagueName;
@property (weak, nonatomic) IBOutlet UILabel *recordTitle;
@property (weak, nonatomic) IBOutlet UILabel *record5Title;

@property (weak, nonatomic) IBOutlet UILabel *rankLb;
@property (weak, nonatomic) IBOutlet UILabel *leagueRecord;
@property (weak, nonatomic) IBOutlet UILabel *nearFiveRecord;

@property (nonatomic, strong) NSDictionary *dict;


- (void)code_checkUserIn;
@end
