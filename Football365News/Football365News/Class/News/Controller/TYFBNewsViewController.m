//
//  TYFBNewsViewController.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/5.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "TYFBNewsViewController.h"

#import "TYFBNewsItemPageView.h"

@interface TYFBNewsViewController ()

@end

@implementation TYFBNewsViewController

#pragma mark - WMPageController DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    //    NSArray *urlArray = @[API_TopNews,API_LIGABBVA,API_PremierLeague,API_Bundesliga,API_SerieA,API_CSL,API_Transfer];
    
    NSArray *urlArray = @[API_TopNews,API_EuropeanCup,API_LIGABBVA,API_PremierLeague,API_Bundesliga,API_SerieA,API_CSL,API_Transfer];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    TYFBNewsItemPageView *vc = [sb instantiateViewControllerWithIdentifier:@"PageView"];
    vc.urlString = urlArray[index];
    return vc;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.menuItemWidth = SCREEN_WIDTH / 5;
        self.menuViewStyle = WMMenuViewStyleFlood;
//        self.titleSizeSelected = 15.0;
        self.titleColorNormal = [UIColor darkGrayColor];
        self.titleColorSelected = [UIColor whiteColor];
        self.progressColor = AppMainColor;
        self.menuHeight = 35;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - LazzyLoad

- (NSArray<NSString *> *)titles {
    //TODO: 多加几个种类？
    return @[@"热门",@"欧洲杯",@"西甲",@"英超",@"德甲",@"意甲",@"中超",@"转会"];
}


@end
