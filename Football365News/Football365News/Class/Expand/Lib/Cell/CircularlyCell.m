//
//  CircularlyCell.m
//  CircularlyView
//
//  Created by Wii on 16/6/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "CircularlyCell.h"
#import "UIImageView+WebCache.h"
@implementation CircularlyCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setPath:(NSIndexPath *)path {
    _path = path;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    NSInteger index = self.path.item % images.count;
    if (![images[index] hasPrefix:@"http"]) {
        self.imageView.image = [UIImage imageNamed:images[index]];
    }
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:images[self.path.item % images.count]]];
}
- (void)setDescribeArray:(NSArray *)describeArray {
    _describeArray = describeArray;
    if (describeArray == nil) {
        return;
    }
    if (describeArray.count > 0 && describeArray) {
        self.display.hidden = NO;
        [self.display setText:_describeArray[self.path.item % _describeArray.count]];
    }
}

- (void)code_checkDualtSetting:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}
@end
