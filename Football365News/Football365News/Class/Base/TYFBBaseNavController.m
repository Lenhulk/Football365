//
//  TYFBBaseNavController.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/6.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "TYFBBaseNavController.h"

@interface TYFBBaseNavController ()

@end

@implementation TYFBBaseNavController

+ (void)initialize {
    // 全局设置 NAV 标题字体颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

///重写push方法 push的控制器隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 隐藏tabbar
    viewController.hidesBottomBarWhenPushed =YES;
    
    //1.添加后退按钮
    [self addBackButton:viewController];
    
    [super pushViewController:viewController animated:animated];
}



//2 自定义后退按钮
- (void)addBackButton:(UIViewController *)viewController {
    
    
    //开启手势后退
    self.interactivePopGestureRecognizer.delegate = (id)self;
    //开启手势滑动后退
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    UIImage *image = [[UIImage imageNamed:@"back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    
    //间距
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -10;
    
    viewController.navigationItem.leftBarButtonItems =@[fixed,back];
    
}

//点击后退的时候执行的方法
- (void)backClick {
    [self popViewControllerAnimated:YES];
}



- (void)code_checkDualtSetting {
    NSLog(@"Get Info Failed");
}
@end
