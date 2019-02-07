//
//  HomeNewsDetailViewController.h
//  SoccerHoneypot
//
//  Created by Wii on 16/6/21.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ArticleModel.h"
@interface TYFBNewsDetailViewController : UIViewController

//@property (nonatomic , strong) NSString *newsUrl;
@property (nonatomic , strong) ArticleModel *model;
@end
