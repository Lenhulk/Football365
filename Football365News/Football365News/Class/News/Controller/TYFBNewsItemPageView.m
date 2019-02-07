//
//  WiiPageContentViewController.m
//  SoccerHoneypot
//
//  Created by Wii on 16/7/6.
//  Copyright © 2016年 Wii. All rights reserved.
//

#import "TYFBNewsItemPageView.h"
#import "TYFBNewsDetailViewController.h"
#import "BaseModel.h"
#import "ArticleModel.h"
#import "NewsCell.h"


#define ShowNewsDetail @"showNewsDetail"

@interface TYFBNewsItemPageView () <UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic , strong) NSMutableArray *dateSource;
@property (nonatomic , strong) BaseModel *model;
@property (nonatomic , strong) NSString *nextPageUrlString;
@property (nonatomic , strong) NSMutableArray *recommendList;
@end

@implementation TYFBNewsItemPageView

#pragma mark - Segue回调
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showNewsDetail"]) {
        TYFBNewsDetailViewController *detailVC = segue.destinationViewController;
        detailVC.model = sender;
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ArticleModel *model = self.recommendList[index];
    [self performSegueWithIdentifier:@"showNewsDetail" sender:model];
}

#pragma mark - Viewlife
- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"object"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
    [self.model addObserver:self forKeyPath:@"object" options:NSKeyValueObservingOptionNew context:nil];
    [self.mainTableView.mj_header beginRefreshing];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self initDataSource];
    
}
- (void)initDataSource {
    WeakSelf;
    [self.model getModelWithURLString:self.urlString completeBlock:^(NSArray *articlesList, NSArray *recommendList, NSString *nextPageUrl) {
        [weakSelf.dateSource removeAllObjects];
        [weakSelf.recommendList removeAllObjects];
        [weakSelf.dateSource addObjectsFromArray:articlesList];
        [weakSelf.recommendList addObjectsFromArray:recommendList];
        weakSelf.nextPageUrlString = nextPageUrl;
        [weakSelf.mainTableView reloadData];
        
    }];
}

-(void)loadMore {
    WeakSelf;
    [self.model getModelWithURLString:self.nextPageUrlString completeBlock:^(NSArray *articlesList, NSArray *recommendList, NSString *nextPageUrl) {
        [weakSelf.dateSource addObjectsFromArray:articlesList];
//        [weakSelf.mainTableView reloadData];
    }];
}

- (void)initUserInterface {
    WeakSelf;
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainTableView.tableFooterView = [UIView new];
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf initDataSource];
        
    }];
    self.mainTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [weakSelf.mainTableView.mj_footer endRefreshing];
        [weakSelf loadMore];
    }];
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.recommendList.count > 0) {
        if (indexPath.row == 0) {
            return 230;
        }
    }
    ArticleModel *model = self.dateSource[indexPath.row];
    return [NewsCell getCellHeigh:model];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCell *cell = nil;
//    WeakSelf;
    if (self.recommendList.count > 0) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellThree"];
            cell.recommendArray = [self.recommendList copy];
            cell.loopScrollView.delegate = self;
            return cell;
        }
    }
    ArticleModel *model = self.dateSource[indexPath.row];
    NSString *identifier = [NewsCell cellIdentifierForRow:model];
    Class mclass = NSClassFromString(identifier);
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mclass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = self.dateSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleModel *model = self.dateSource[indexPath.row];
    [self performSegueWithIdentifier:@"showNewsDetail" sender:model];
}



#pragma mark - LazzyLoad

- (NSMutableArray *)dateSource {
    if (!_dateSource) {
        _dateSource = [NSMutableArray array];
    }
    return _dateSource;
}

- (NSMutableArray *)recommendList {
    if (!_recommendList) {
        _recommendList = [NSMutableArray array];
    }
    return _recommendList;
}

- (BaseModel *)model {
    if (!_model) {
        _model = [[BaseModel alloc]init];
    }
    return _model;
}

#pragma mark - KVO 回调

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self.mainTableView reloadData];
}
@end
