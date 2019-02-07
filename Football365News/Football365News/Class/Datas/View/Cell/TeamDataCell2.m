//
//  TeamDataCell2.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "TeamDataCell2.h"

@interface TeamDataCell2()

@property (weak, nonatomic) IBOutlet UILabel *firTitLb;
@property (weak, nonatomic) IBOutlet UILabel *secTitLb;
@property (weak, nonatomic) IBOutlet UILabel *thiTitLb;
@property (weak, nonatomic) IBOutlet UILabel *fouTitLb;
@property (weak, nonatomic) IBOutlet UILabel *firNumLb;
@property (weak, nonatomic) IBOutlet UILabel *secNumLb;
@property (weak, nonatomic) IBOutlet UILabel *thiNumLb;
@property (weak, nonatomic) IBOutlet UILabel *fouNumLb;

@end

@implementation TeamDataCell2

- (void)setArray:(NSArray *)array{
    _array = array;
    if (array.count<4) {
        self.fouTitLb.text = @"";
        self.fouNumLb.text = @"";
    }
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict = array[i];
        NSString *type = dict[@"type"];
        NSString *number = dict[@"number"];
        if (i==0) {
            self.firTitLb.text = type;
            self.firNumLb.text = number;
        } else if (i==1) {
            self.secTitLb.text = type;
            self.secNumLb.text = number;
        } else if (i == 2) {
            self.thiTitLb.text = type;
            self.thiNumLb.text = number;
        } else {
            self.fouTitLb.text = type;
            self.fouNumLb.text = number;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)code_didGetInfoSss {
    NSLog(@"Get User Succrss");
}
@end
