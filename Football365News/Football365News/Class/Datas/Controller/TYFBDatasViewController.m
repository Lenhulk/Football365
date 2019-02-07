//
//  TYFBDatasViewController.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/29.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "TYFBDatasViewController.h"
#import "TYFBDatasItemPageViewController.h"

@interface TYFBDatasViewController ()

@end

@implementation TYFBDatasViewController


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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WMPageController DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    NSArray *urlArray = @[API_CSL_Datas,API_LIGABBVA_Datas,API_PremierLeague_Datas,API_Bundesliga_Datas,API_SerieA_Datas,API_CLO_Datas];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Data" bundle:nil];
    TYFBDatasItemPageViewController *vc = [sb instantiateViewControllerWithIdentifier:@"PageView"];
    vc.urlString = urlArray[index];
    
    return vc;
}

#pragma mark - LazzyLoad

- (NSArray<NSString *> *)titles {
    return @[@"中超",@"西甲",@"英超",@"德甲",@"意甲",@"中甲"];
}


- (void)code_checkDualtSetting {
    NSLog(@"Get User Succrss");
}
@end
