//
//  LJHHomeViewController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHHomeViewController.h"
#import "LJHTitleButton.h"
#import "LJHAccount.h"
#import "LJHAccountTool.h"
#import "LJHStatus.h"
#import "LJHUser.h"
#import "LJHStatusFrame.h"
#import "LJHStatusCell.h"
#define LJHTitleButtonDown 0
#define LJHTitleButtonUp -1
@interface LJHHomeViewController()
@property (nonatomic, weak) LJHTitleButton *titleButton;
@property (strong, nonatomic) NSMutableArray *statuFrames;
@end

@implementation LJHHomeViewController

- (NSMutableArray *)statuFrames{
    if (_statuFrames == nil) {
        _statuFrames = [NSMutableArray array];
    }
    return _statuFrames;
}

-(void)viewDidLoad{
    [self setupUserData];
    [self setupRefresh];
    [self setupNav];
}

/**
 *  读取用户信息
 */
- (void)setupUserData{
    
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LJHAccountTool account].access_token;
    params[@"uid"] = @([LJHAccountTool account].uid);
    
    // 2.请求
    [LJHHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        // 字典转模型
        LJHUser *user = [LJHUser objectWithKeyValues:json];
        // 设置标题文字
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 保存昵称
        LJHAccount *account = [LJHAccountTool account];
        account.name = user.name;
        [LJHAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupRefresh{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"下拉刷新";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
    self.tableView.footerRefreshingText = @"正在刷新中";
}

- (void)headerRefreshing{
    [self loadNewData];
}

- (void)footerRefreshing{
    [self loadMoreData];
}

- (void)loadNewData{
    
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LJHAccount *account = [LJHAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"count"] = [NSString stringWithFormat:@"%d",5];
    if (self.statuFrames.count) {
        LJHStatusFrame *statusFrame = self.statuFrames[0];
        params[@"since_id"] = statusFrame.status.idstr;
    }
    
    // 2.请求
    [LJHHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
        //字典数组转模型数组
        NSArray *statusArray = [LJHStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        //创建statusFrame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (LJHStatus *status in statusArray) {
            LJHStatusFrame *statusFrame = [[LJHStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        //赋值
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statuFrames];
        self.statuFrames = tempArray;
        
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        
        [self showNewStatusCount:(int)statusFrameArray.count];
    } failure:^(NSError *error) {
        LJHLog(@"请求失败 : %@",error);
        [self.tableView headerEndRefreshing];
    }];
}

- (void)loadMoreData{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LJHAccount *account = [LJHAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"count"] = [NSString stringWithFormat:@"%d",5];
    if (self.statuFrames.count) {
        LJHStatusFrame *statusFrame = [self.statuFrames lastObject];
        long long  max_id = [statusFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(max_id);
    }
    
    // 2.请求
    [LJHHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
        
        //字典数组转模型数组
        NSArray *statusArray = [LJHStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        //创建statusFrame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (LJHStatus *status in statusArray) {
            LJHStatusFrame *statusFrame = [[LJHStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        [self.statuFrames addObjectsFromArray:statusFrameArray];
        
        [self.tableView reloadData];
        
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        LJHLog(@"请求失败 : %@",error);
        [self.tableView footerEndRefreshing];
    }];

}

- (void)showNewStatusCount:(int)count{
    UIButton *btn = [[UIButton alloc] init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    btn.userInteractionEnabled = NO;
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        [btn setTitle:[NSString stringWithFormat:@"共有%d条新的微博",count] forState:UIControlStateNormal];
        
    }
    else{
        [btn setTitle:@"没有新的微博" forState:UIControlStateNormal];
    }
    
    CGFloat btnX = 2;
    
    CGFloat btnW = self.view.frame.size.width - 2*btnX;
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
}

- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(popClick)];
    
    LJHTitleButton *titleButton = [LJHTitleButton titleButton];
    self.titleButton = titleButton;
    titleButton.tag = LJHTitleButtonDown;
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.frame = CGRectMake(0, 0, 0, 40);
    LJHAccount *account = [LJHAccountTool account];
    if (account) {
        [titleButton setTitle:account.name forState:UIControlStateNormal];
    }
    else{
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    
    
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = LJHColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, LJHStatusTableBorder, 0);
}

- (void)titleButtonClick:(LJHTitleButton *)button{
    if (button.tag == LJHTitleButtonDown) {
        [button setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        button.tag = LJHTitleButtonUp;
    }
    else
    {
        [button setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        button.tag = LJHTitleButtonDown;
    }
}

- (void)friendSearch{
    
}

- (void)popClick{
    
}

/**
 *  快速创建一个barButtonItem
 *
 *  @param icon     图片
 *  @param highIcon 选中时的图片
 *  @param action   对应的事件
 */
- (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LJHStatusCell *cell = [LJHStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statuFrames[indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LJHStatusFrame *statusFrame = self.statuFrames[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor grayColor];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
