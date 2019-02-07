//
//  HomeNewsDetailViewController.m
//  SoccerHoneypot
//
//  Created by Wii on 16/6/21.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "TYFBNewsDetailViewController.h"
#import <MBProgressHUD.h>

@interface TYFBNewsDetailViewController () <WKNavigationDelegate>

@property (nonatomic , strong) WKWebView *wkWeb;
@end

@implementation TYFBNewsDetailViewController


#pragma mark - Delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"头条详情";
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    [self makeRightButton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]]];
    });
}

- (void)makeRightButton {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 80, 20);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    rightButton.layer.borderWidth = 1.0;
    rightButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    [rightButton setTitle:[NSString stringWithFormat:@"%ld条评论",self.model.comments_total] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonHandleEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}


#pragma mark - RightButton HandleEvent

- (void)rightButtonHandleEvent:(UIButton *)sender {
    DLog(@"hehe");
}

#pragma mark - LazzyLoad
- (WKWebView *)wkWeb {
    if (!_wkWeb) {
        _wkWeb = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _wkWeb.allowsBackForwardNavigationGestures = YES;
        _wkWeb.navigationDelegate = self;
        [self.view addSubview:_wkWeb];
    }
    return _wkWeb;
}


@end
