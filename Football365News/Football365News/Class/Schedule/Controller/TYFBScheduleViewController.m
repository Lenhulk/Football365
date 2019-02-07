//
//  TYFBScheduleViewController.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/5.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "TYFBScheduleViewController.h"
#import "TYFBMatchDetailViewController.h"
#import "ScheduleCell.h"
#import "ScheduleModel.h"
@interface TYFBScheduleViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic , strong) ScheduleModel *model;
@property (nonatomic , strong) NSMutableDictionary *dataDictionary;
@property (nonatomic , strong) NSMutableArray *keyArray;
@property (nonatomic, strong) NSDateFormatter *ymdFmt;
//一开始滚动到那个section
@property (nonatomic, assign) NSInteger curSection;
@end

@implementation TYFBScheduleViewController

#pragma mark - LazzyLoad
- (NSDateFormatter *)ymdFmt{
    if(_ymdFmt == nil) {
        _ymdFmt = [[NSDateFormatter alloc] init];
        //        _fmt.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        _ymdFmt.dateFormat = @"yyyy-MM-dd";
    }
    return _ymdFmt;
}
- (NSMutableArray *)keyArray {
    if (!_keyArray) {
        _keyArray = [NSMutableArray array];
    }
    return _keyArray;
}

- (NSMutableDictionary *)dataDictionary {
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}

- (ScheduleModel *)model {
    if (!_model) {
        _model = [[ScheduleModel alloc]init];
    }
    return _model;
}

#pragma mark - View lifqw
- (void)dealloc {
    // 移除观察者
    [self.model removeObserver:self forKeyPath:@"object"];
    DLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加观察者
    [self.model addObserver:self forKeyPath:@"object" options:NSKeyValueObservingOptionNew context:nil];
    // 设置刷新控件等
    [self initUserInterface];
    // 开始刷新
    [self.mainTableView.mj_header beginRefreshing];
   
}
#pragma mark - 获取Json 数据
//https://api.dongqiudi.com/data/tab/new/important?start=2018-07-2516:00:00&init=1
- (void)initDataSource {
    WeakSelf;
    NSDate *date = [NSDate date];
    NSString *dateString = [date formattedDateWithFormat:@"YYYY-MM-dd16:00:00"];
    [self.model getCellModelDataWithURLString:[NSString stringWithFormat:@"%@%@%@",API_Schedule,dateString,@"&init=1"] SectionKeyAndDictionary:^(NSArray *keyArray, NSDictionary *dataDictionary) {
        weakSelf.keyArray = keyArray.mutableCopy;
        weakSelf.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:dataDictionary];
        [weakSelf.mainTableView reloadData];
        
        if (weakSelf.curSection == 0) {
            return ;
        }
        [weakSelf.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:weakSelf.curSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }];
}

//https://api.dongqiudi.com/data/tab/new/important?start=2018-08-0316:00:00next
- (void)loadMore {
    WeakSelf;
    NSString *dateString = [self.model getUpdateToNextDate];
//    dateString = [dateString substringToIndex:10];
    dateString = [dateString stringByReplacingOccurrencesOfString:@" " withString:@""]; // 删除参数中的空格
    [self.model getCellModelDataWithURLString:[NSString stringWithFormat:@"%@%@",API_Schedule,dateString] SectionKeyAndDictionary:^(NSArray *keyArray, NSDictionary *dataDictionary) {
        [weakSelf.keyArray addObjectsFromArray:keyArray];
        [weakSelf.dataDictionary addEntriesFromDictionary:dataDictionary];
        [weakSelf.mainTableView reloadData];
    }];
}

#pragma mark - 页面相关
- (void)initUserInterface {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainTableView.tableFooterView = [UIView new];
    WeakSelf;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.curSection = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf initDataSource];
            [weakSelf.mainTableView.mj_header endRefreshing];
            
            
        });
    }];
    self.mainTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadMore];
            [weakSelf.mainTableView.mj_footer endRefreshing];
        });
    }];
}




#pragma mark - KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self.mainTableView reloadData];
    DLog(@"KVO");
}


#pragma mark - <UITabBarDelegate,UITableViewDataSource>
#pragma mark -- Section
// 配置Section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keyArray.count;
}
// 配置区段 时间的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *timeStr = self.keyArray[section];
    NSDate *timeDate = [self.ymdFmt dateFromString:timeStr];
    NSString *addStr;
    if ([timeDate isToday]) {
        addStr = @"今天";
        self.curSection = section;
    } else if ([timeDate isYesterday]) {
        addStr = @"昨天";
        if (self.curSection == 0) {
            self.curSection = section;
        }
    } else if ([timeDate isTomorrow]) {
        addStr = @"明天";
        if (self.curSection == 0) {
            self.curSection = section;
        }
    } else {
        addStr = [self getWeekDayForDate:timeDate];
    }
    timeStr = [NSString stringWithFormat:@"%@  %@", timeStr, addStr];
    return timeStr;
}


#pragma mark -- CELL
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 取数据
    NSString *key = self.keyArray[section];
    NSArray *array = self.dataDictionary[key];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleCELL"];
    // 取数组
    NSString *key = self.keyArray[indexPath.section];
    NSArray *array = self.dataDictionary[key];
    ScheduleModel *model = array[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = self.keyArray[indexPath.section];
    NSArray *array = self.dataDictionary[key];
    ScheduleModel *model = array[indexPath.row];
    [self performSegueWithIdentifier:@"ShowMatchDetail" sender:model];
    
}

#pragma mark - 时间处理
//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

// 获取到当前date是星期几
- (NSString *)getWeekDayForDate:(NSDate *)date
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    //    NSDate *nDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

#pragma mark - Segue 回调
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowMatchDetail"]) {
        TYFBMatchDetailViewController *matchVC = segue.destinationViewController;
        matchVC.model = (ScheduleModel *)sender;
    }
}




@end
