//
//  PersonCell.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/31.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *siteLb;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImgv;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *timesLb;


- (void)code_didUserInfoFailed;
@end
