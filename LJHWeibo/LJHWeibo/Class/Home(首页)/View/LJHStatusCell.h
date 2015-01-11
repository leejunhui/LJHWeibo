//
//  LJHStatusCell.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJHStatusFrame;
@interface LJHStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (strong, nonatomic) LJHStatusFrame *statusFrame;
@end
