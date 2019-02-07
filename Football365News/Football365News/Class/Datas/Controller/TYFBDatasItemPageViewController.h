//
//  TYFBDatasItemPageViewController.h
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/29.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYFBDatasItemPageViewController : UIViewController
@property (nonatomic, copy) NSString *urlString;

- (void)code_getUsersMoLiked:(NSString *)mediaInfo;
@end
