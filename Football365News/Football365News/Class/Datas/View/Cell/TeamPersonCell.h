//
//  TeamPersonCell.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamPersonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *personCollectionView;
//@property (nonatomic, strong) NSArray *persons;

//- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate;




- (void)code_getUsersMoLiked:(NSString *)string;
@end
