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
@property (strong, nonatomic) NSArray *statuFrames;
@end

@implementation LJHHomeViewController

- (NSArray *)statuFrames{
    if (_statuFrames == nil) {
        _statuFrames = [NSArray array];
    }
    return _statuFrames;
}

-(void)viewDidLoad{
    [self setupNav];
    [self setupStatusData];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //说明服务器返回的是json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LJHAccount *account = [LJHAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"count"] = [NSString stringWithFormat:@"%d",50];
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //字典数组转模型数组
        NSArray *statusArray = [LJHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //创建statusFrame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (LJHStatus *status in statusArray) {
            LJHStatusFrame *statusFrame = [[LJHStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        //赋值
        self.statuFrames = statusFrameArray;
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LJHLog(@"请求失败 : %@",error);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}

- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(popClick)];
    
    LJHTitleButton *titleButton = [LJHTitleButton titleButton];
    titleButton.tag = LJHTitleButtonDown;
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleButton setTitle:@"哈哈哈" forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 120, 40);
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
    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
@end
