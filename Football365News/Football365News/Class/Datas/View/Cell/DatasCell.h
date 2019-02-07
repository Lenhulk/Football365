//
//  DatasCell.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/29.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DatasModel;
@interface DatasCell : UITableViewCell
@property (nonatomic, strong) DatasModel *model;

- (void)code_getMediata:(NSString *)string;
@end
