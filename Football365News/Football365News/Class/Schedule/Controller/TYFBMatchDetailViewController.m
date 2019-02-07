//
//  TYFBMatchDetailViewController.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/15.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "TYFBMatchDetailViewController.h"
#import "EventCalendar.h"
#import "WiiNetWorkTool.h"
#import <UIImageView+WebCache.h>
#import <WMPlayer.h>
#import <Masonry.h>
#import <FCAlertView.h>
#import <MBProgressHUD.h>

@interface TYFBMatchDetailViewController () <WKNavigationDelegate, WMPlayerDelegate>
// TopView相关属性
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UIImageView *hTeamImgv;
@property (weak, nonatomic) IBOutlet UIImageView *aTeamImgv;
@property (weak, nonatomic) IBOutlet UILabel *hTeamLb;
@property (weak, nonatomic) IBOutlet UILabel *aTeamLb;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLb;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
// 重播按钮
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIButton *liveBtn;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *liveUrl;

@property (nonatomic , strong) WKWebView *wkWeb;
@property (nonatomic, strong) WMPlayer *wmPlayer;
@end

@implementation TYFBMatchDetailViewController

#pragma mark - 旋转屏幕
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
    if (self.wmPlayer==nil){
        return;
    }
    if (self.wmPlayer.playerModel.verticalVideo) {
        return;
    }
    if (self.wmPlayer.isLockScreen){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default:
            break;
    }
}
//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    //获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    [self.wmPlayer removeFromSuperview];
    //根据要旋转的方向,使用Masonry重新修改限制
    if (orientation ==UIInterfaceOrientationPortrait) {
        [self.view addSubview:self.wmPlayer];
        self.wmPlayer.isFullscreen = NO;
        self.wmPlayer.backBtnStyle = BackBtnStyleClose;
        
        [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.wmPlayer.superview).offset([WMPlayer IsiPhoneX]?88:64);
//            make.leading.trailing.equalTo(self.wmPlayer.superview);
//            make.height.equalTo(@(([UIScreen mainScreen].bounds.size.width)*9/16.0));
//            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.leading.top.trailing.equalTo(self.view);
            make.height.mas_equalTo(200);
        }];
        
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
        self.wmPlayer.isFullscreen = YES;
        self.wmPlayer.backBtnStyle = BackBtnStylePop;
        
        if(currentOrientation ==UIInterfaceOrientationPortrait){
            if (self.wmPlayer.playerModel.verticalVideo) {
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.wmPlayer.superview);
                }];
            }else{
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
                    make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
                    make.center.equalTo(self.wmPlayer.superview);
                }];
            }
            
        }else{
            if (self.wmPlayer.playerModel.verticalVideo) {
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.wmPlayer.superview);
                }];
            }else{
                [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
                    make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
                    make.center.equalTo(self.wmPlayer.superview);
                }];
            }
            
        }
    }
    //iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    //也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    if (self.wmPlayer.playerModel.verticalVideo) {
        [self setNeedsStatusBarAppearanceUpdate];
    }else{
        [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
        //更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
        //给你的播放视频的view视图设置旋转
        [UIView animateWithDuration:0.4 animations:^{
            self.wmPlayer.transform = CGAffineTransformIdentity;
            self.wmPlayer.transform = [WMPlayer getCurrentDeviceOrientation];
            [self.wmPlayer layoutIfNeeded];
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
}

#pragma mark - VIEW LIFE
- (void)dealloc{
    NSLog(@"%s", __func__);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self releaseWMPlayer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    self.videoBtn.layer.backgroundColor = MyRGBColor(45, 174, 53).CGColor;
    self.videoBtn.layer.cornerRadius = 5;
    self.liveBtn.layer.backgroundColor = [UIColor redColor].CGColor;
    self.liveBtn.layer.cornerRadius = 5;
    
    [self setupTopView];

    //TODO: 改
    [self setupMatchInfoWebView];
    // 获取赛程一些咨询
    [[WiiNetWorkTool sharedWiiNetWorkTool] requestWithMethod:WiiNetWorkMethodGet URLString:API_ScheduleDetail(self.model.match_id) parameters:nil finished:^(id object, NSError *error) {
        
        NSDictionary *dictObj = object;
        
        NSDictionary *videoInfo = dictObj[@"video"];
        if (videoInfo != nil)
            self.videoUrl = videoInfo[@"url"];
        
        NSDictionary *liveInfo = [dictObj[@"matchLiving"] firstObject];
        if (liveInfo != nil)
            self.liveUrl = liveInfo[@"url"];
        
    }];
}

- (void)setupTopView {
    // 背景
    UIImage *image = [UIImage imageNamed:@"door"];
    self.topView.layer.contents = (id)image.CGImage;
    self.topView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    // 开赛时间加8小时
    NSString *openHms = [self getTimeStringFor:self.model.start_play withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    openHms = [openHms substringWithRange:NSMakeRange(5, 11)];
    self.gameName.text = [NSString stringWithFormat:@"%@ %@", openHms,  self.model.match_title];
    
    // 队伍
    self.hTeamLb.text = self.model.team_A_name;
    self.aTeamLb.text = self.model.team_B_name;
    UIImage *zhanweiImg = [UIImage imageNamed:@"fbph"];
    [self.hTeamImgv sd_setImageWithURL:[NSURL URLWithString:self.model.team_A_logo] placeholderImage:zhanweiImg];
    [self.aTeamImgv sd_setImageWithURL:[NSURL URLWithString:self.model.team_B_logo] placeholderImage:zhanweiImg];
    
    // 比分
    self.scoreLb.text = [NSString stringWithFormat:@"%@ - %@", self.model.fs_A, self.model.fs_B];
    if ([self.model.status isEqualToString:@"Played"]) {
        self.gameStatusLb.text = @"【完场】";
        
    } else if ([self.model.status isEqualToString:@"Playing"]) {
        self.gameStatusLb.text = [NSString stringWithFormat:@"【进行中 %@'】", self.model.playing_time];
        
    } else {
        self.gameStatusLb.text = @"【未开赛】";
        self.scoreLb.text = @"0 - 0";
    }
    
    // 是否可以播放视频
    self.liveBtn.hidden = YES;
    self.liveBtn.userInteractionEnabled = NO;
    self.videoBtn.hidden = YES;
    self.videoBtn.userInteractionEnabled = NO;
    if (self.model.webLivingFlag){
        self.liveBtn.hidden = NO;
        self.liveBtn.userInteractionEnabled = YES;
    }
    if (self.model.videoFlag) { // 回看优先级高于直播
        self.videoBtn.hidden = NO;
        self.videoBtn.userInteractionEnabled = YES;
        self.liveBtn.hidden = YES;
        self.liveBtn.userInteractionEnabled = NO;
    }
}

- (void)setupMatchInfoWebView {
    [self.wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_MatchInfo,self.model.match_id]]]];
    [self.view addSubview:self.wkWeb];
}

#pragma mark - ACTIONS
- (IBAction)tapLiveBtn:(id)sender {
    NSURL *url = [NSURL URLWithString:self.liveUrl];
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        FCAlertView *alertView = [[FCAlertView alloc] init];
        [alertView makeAlertTypeCaution];
        alertView.detachButtons = YES;
        [alertView showAlertInView:self withTitle:@"温馨提示" withSubtitle:@"直播链接失效，请等待赛事回放" withCustomImage:nil withDoneButtonTitle:@"好的" andButtons:nil];
    }
}

- (IBAction)tapVideoBtn:(id)sender {
    if(self.videoUrl == nil) {
        FCAlertView *alertView = [[FCAlertView alloc] init];
        [alertView makeAlertTypeCaution];
        alertView.detachButtons = YES;
        [alertView showAlertInView:self withTitle:@"温馨提示" withSubtitle:@"视频链接失效，正在努力修复中" withCustomImage:nil withDoneButtonTitle:@"好的" andButtons:nil];
        return;
    }
    WMPlayerModel *playerModel = [WMPlayerModel new];
    playerModel.title = [NSString stringWithFormat:@"%@  %@vs%@", self.model.match_title, self.model.team_A_name, self.model.team_B_name];
    playerModel.videoURL = [NSURL URLWithString:self.videoUrl];
    WMPlayer * wmPlayer = [[WMPlayer alloc] initPlayerModel:playerModel];
//    wmPlayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    [self.view addSubview:wmPlayer];
    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    self.wmPlayer = wmPlayer;
    wmPlayer.delegate = self;
    [wmPlayer play];
}

- (IBAction)BackButtonHandleEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapAddToCalender:(id)sender {
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否将比赛加入提醒事项" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"不添加" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
            [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"要添加" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
           
           EventCalendar *calendar = [EventCalendar sharedEventCalendar];
           NSString * teamString = [NSString stringWithFormat:@"%@VS%@ 开赛提醒", self.model.team_A_name, self.model.team_B_name];
           NSString * dataString = self.model.start_play;//UTC
           
           
           // 转换成本地时区
           NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
           [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
           [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
           NSDate *resDate = [formatter dateFromString:dataString];
           NSTimeZone *systimeZone = [NSTimeZone systemTimeZone];
           NSInteger interval = [systimeZone secondsFromGMTForDate:resDate];
           NSDate *localeDate = [resDate  dateByAddingTimeInterval:interval];
           [formatter setTimeZone:systimeZone];
           NSString *localDateStr = [formatter stringFromDate:localeDate];
           
           [calendar createEventCalendarTitle:teamString location:[NSString stringWithFormat:@"比赛开始于%@，记得观看哦~",localDateStr] startDate:[NSDate dateWithTimeInterval:-1800 sinceDate:localeDate] endDate:[NSDate dateWithTimeInterval:3600 sinceDate:localeDate] allDay:NO alarmArray:@[@"-1800"]];
                       }];
    [alert addAction:saveAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (NSString *)getTimeStringFor:(NSString *)timeString withDateFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeString];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return [dateFormatter stringFromDate:localeDate];
}


#pragma mark - LAZY
- (WKWebView *)wkWeb {
    if (!_wkWeb) {
        _wkWeb = [[WKWebView alloc]initWithFrame:CGRectMake(0,200, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
        _wkWeb.allowsBackForwardNavigationGestures = YES;
        _wkWeb.navigationDelegate = self;
    }
    return _wkWeb;
}


#pragma mark - WMPlayer
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"didClickedCloseButton");
    if (wmplayer.isFullscreen) {
        [self toOrientation:UIInterfaceOrientationPortrait];
    }else{
        [self releaseWMPlayer];
    }
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (self.wmPlayer.isFullscreen) {//全屏
        [self toOrientation:UIInterfaceOrientationPortrait];
    }else{//非全屏
        [self toOrientation:UIInterfaceOrientationLandscapeRight];
    }
}
//操作栏隐藏或者显示都会调用此方法
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    [self setNeedsStatusBarAppearanceUpdate];
}
/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    [self.wmPlayer pause];
    [self.wmPlayer removeFromSuperview];
    self.wmPlayer = nil;
}

-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    if (state == WMPlayerStateFailed) {
        FCAlertView *alertView = [[FCAlertView alloc] init];
        [alertView makeAlertTypeCaution];
        alertView.detachButtons = YES;
        [alertView showAlertInView:self withTitle:@"温馨提示" withSubtitle:@"视频链接失效，是否要跳转到外链观看" withCustomImage:nil withDoneButtonTitle:@"好啊" andButtons:@[@"不了"]];
        alertView.doneBlock = ^{
            NSURL *url = [NSURL URLWithString:self.videoUrl];
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
        };
    }
}

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

@end
