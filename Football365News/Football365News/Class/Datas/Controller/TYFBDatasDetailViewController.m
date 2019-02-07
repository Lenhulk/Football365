//
//  TYFBDatasDetailViewController.m
//  SoccerHoneypot
//
//  Created by 大雄 on 2018/7/30.
//  Copyright © 2018年 Wii. All rights reserved.
//

#import "TYFBDatasDetailViewController.h"
#import "DatasTeamModel.h"
#import "TeamDataCell.h"
#import "TeamDataCell2.h"
#import "TeamPersonCell.h"
#import "PersonCell.h"
#import <MBProgressHUD.h>

@interface TYFBDatasDetailViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
// Top PROPERTYS
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIImageView *teamLogo;
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UIImageView *countryFlag;
@property (weak, nonatomic) IBOutlet UILabel *teamEName;
@property (weak, nonatomic) IBOutlet UILabel *teamOther;
// DATAS
@property (nonatomic, strong) DatasTeamModel *model;
@property (nonatomic, strong) NSDictionary *season;
@property (nonatomic, strong) NSArray *person;
@property (nonatomic, strong) NSDictionary *statistics;
// VIEWS
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TYFBDatasDetailViewController

#pragma mark - VIEW LIFE
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    WeakSelf;
    [self.model getTeamProfileWithUrlString:API_TeamProfile(self.teamId) complete:^(DatasTeamModel *model) {
        weakSelf.model = model;   //??补充模型数据
        [weakSelf setupTopTeamView];
    }];
    [self.model getDataWithURLString:API_TeamDetail(self.teamId) completeBlock:^(NSDictionary *season, NSArray *person, NSDictionary *statistics) {
        weakSelf.season = season;
        weakSelf.person = person;
        weakSelf.statistics = statistics;
        [weakSelf.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}

- (void)setupTopTeamView{
    UIImage *img = [UIImage imageNamed:@"teamBack"];
    self.topBgView.layer.contents = (id)img.CGImage;
    self.topBgView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    self.teamName.text = self.model.team_name;
    self.teamEName.text = self.model.team_en_name;
    [self.teamLogo sd_setImageWithURL:[NSURL URLWithString:self.model.team_logo]];
    [self.countryFlag sd_setImageWithURL:[NSURL URLWithString:self.model.country_logo]];
    self.teamOther.text = [NSString stringWithFormat:@"%@年 /%@ /%@", self.model.founded, self.model.country, self.model.city];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ACTIONS
- (IBAction)tapGoBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ACTIONS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.person.count == 0 || self.statistics.count == 0) {
        return 2;
    }else{
        return 1+1+self.statistics.allKeys.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 88;
    } else if (indexPath.row == 5) {
        //TODO: 从cell返回？
        return 461;
    } else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TeamDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamTopCell"];
        cell.dict = self.season;
        return cell;
    }
    if (self.statistics.count == 0) {
        // 无数据
        TeamDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamTopCell"];
        cell.leagueName.text = @"";
        cell.recordTitle.text = @"本赛季未开";
        cell.record5Title.text = @"";
        cell.rankLb.text = @"";
        cell.leagueRecord.text = @"暂无详细数据";
        cell.leagueRecord.textColor = [UIColor redColor];
        cell.nearFiveRecord.text = @"";
        return cell;
    } else {
        // 有数据
        if (indexPath.row == 5) {
            TeamPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamPersonCell"];
            [cell.personCollectionView reloadData];
            return cell;
        } else {
            TeamDataCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"TeamNormalCell"];
            if (indexPath.row == 1) {
                cell.titleLb.text = @"进攻";
                cell.array = self.statistics[@"attack"];
            } else if (indexPath.row == 2) {
                cell.titleLb.text = @"组织";
                cell.array = self.statistics[@"organize"];
            } else if (indexPath.row == 3) {
                cell.titleLb.text = @"防守";
                cell.array = self.statistics[@"defensive"];
            } else {
                cell.titleLb.text = @"纪律";
                cell.array = self.statistics[@"discipline"];
            }
            return cell;
        }
    }
}


#pragma mark - CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.person.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PersonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PersonCell" forIndexPath:indexPath];
    NSDictionary *manDict = self.person[indexPath.item];
    cell.siteLb.text = manDict[@"type"];
    cell.nameLb.text = manDict[@"person"][@"name"];
    cell.timesLb.text = [NSString stringWithFormat:@"%@次", manDict[@"number"]];
    NSString *picUrl = manDict[@"person"][@"logo"];
    [cell.pictureImgv sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    
    return cell;
}


#pragma mark - LazyLoad
- (DatasTeamModel *)model{
    if (!_model) {
        _model = [[DatasTeamModel alloc] init];
    }
    return _model;
}


- (void)code_checkUserIn {
    NSLog(@"Get Info Success");
}
@end
