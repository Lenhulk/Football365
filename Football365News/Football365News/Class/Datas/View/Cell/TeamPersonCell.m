//
//  TeamPersonCell.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "TeamPersonCell.h"


@implementation TeamPersonCell

//- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate{
//    self.personCollectionView.delegate = dataSourceDelegate;
//    self.personCollectionView.dataSource = dataSourceDelegate;
//    [self.personCollectionView reloadData];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.personCollectionView registerNib:[UINib nibWithNibName:@"PersonCell" bundle:nil] forCellWithReuseIdentifier:@"PersonCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)code_getUsersMoLiked:(NSString *)string {
    NSLog(@"Get Info Success");
}
@end
