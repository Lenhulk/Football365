//
//  HomeNewsDetailViewController.m
//  SoccerHoneypot
//
//  Created by Wii on 16/6/21.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "TYFBNewsDetailViewController.h"
#import <MBProgressHUD.h>

@interface TYFBNewsDetailViewController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic , strong) WKWebView *wkWeb;
@end

@implementation TYFBNewsDetailViewController


#pragma mark - Delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    //打印HTML
    NSString *doc = @"document.body.outerHTML";
    [webView evaluateJavaScript:doc
              completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
                  if (error) {
                      NSLog(@"JSError:%@",error);
                  }
                  NSLog(@"html:%@",htmlStr);
              }] ;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *url = navigationAction.request.URL.absoluteString;
    NSLog(@"===>【web】确定是否navigate: %@", url);
    
    //头部跳转标识
    if (![url hasPrefix:@"http"]) {
        // 充值 需要跳转
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    //（点击了超链接）target="_blank"假如是重新打开窗口的话
    if (!navigationAction.targetFrame.isMainFrame) {
        //        [webView loadRequest:navigationAction.request];
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    }
    return nil;
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"头条详情";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self makeRightButton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSURL *url = [NSURL URLWithString:self.model.url];
//    NSURL *url = [NSURL URLWithString:@"https://www.apple.com"];
        [self.wkWeb loadRequest:[NSURLRequest requestWithURL:url]];
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
        // WKWebView的配置
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        //        [userContentController addUserScript:wkUScript];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController   = userContentController;
        
        WKWebView *webV = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        
        webV.allowsBackForwardNavigationGestures = YES;
        webV.navigationDelegate = self;
        webV.UIDelegate = self;
        webV.backgroundColor = [UIColor redColor];
        [self.view addSubview:webV];
        _wkWeb = webV;
    }
    return _wkWeb;
}


@end
