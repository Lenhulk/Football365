//
//  TYFBDatasItemPageViewController.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/29.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "TYFBDatasItemPageViewController.h"
#import "DatasModel.h"
#import "DatasCell.h"
#import "DatasHeaderView.h"
#import "TYFBDatasDetailViewController.h"

static NSString * const identifier = @"TeamListCell";
@interface TYFBDatasItemPageViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (nonatomic , strong) DatasModel *model;
@property (nonatomic , strong) NSArray *dataObjs;
@property (nonatomic , strong) NSArray *headerItem;
@property (nonatomic, strong) NSString *descStr;
@end

@implementation TYFBDatasItemPageViewController

#pragma mark - ViewLife

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
    [self.dataTableView.mj_header beginRefreshing];
}

- (void)initUserInterface {
    WeakSelf;
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataTableView.tableFooterView = [UIView new];
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataTableView.mj_header endRefreshing];
            [weakSelf initDataSource];
        });
    }];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"DatasHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"Header"];
}

- (void)initDataSource{
    WeakSelf;
    [self.model getModelWithURLString:self.urlString completeBlock:^(NSString *description, NSArray *dataObjs, NSArray *header) {
        weakSelf.descStr = description;
        weakSelf.headerItem = header;
        weakSelf.dataObjs = dataObjs;
        [weakSelf.dataTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataObjs.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DatasHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DatasCell *cell;
    Class mclass = NSClassFromString(identifier);
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mclass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = self.dataObjs[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //传teamID
    DatasModel *model = self.dataObjs[indexPath.row];
    [self performSegueWithIdentifier:@"showTeamDetail" sender:model.team_id];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showTeamDetail"]) {
        TYFBDatasDetailViewController *teamVc = segue.destinationViewController;
        teamVc.teamId = (NSString *)sender;
    }
}


#pragma mark - LazzyLoad
- (DatasModel *)model{
    if (!_model) {
        _model = [[DatasModel alloc] init];
    }
    return _model;
}


- (void)code_getUsersMoLiked:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}
@end
