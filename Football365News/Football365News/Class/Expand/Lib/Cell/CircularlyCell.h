//
//  CircularlyCell.h
//  CircularlyView
//
//  Created by Wii on 16/6/14.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularlyCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (nonatomic , strong) NSIndexPath *path;
@property (nonatomic , strong) NSArray *images;
@property (nonatomic , strong) NSArray *describeArray;

- (void)code_checkDualtSetting:(NSString *)mediaCount;
@end
