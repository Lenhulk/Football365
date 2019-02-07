//
//  TeamDataCell2.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamDataCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (nonatomic, strong) NSArray *array;


- (void)code_didGetInfoSss;
@end
