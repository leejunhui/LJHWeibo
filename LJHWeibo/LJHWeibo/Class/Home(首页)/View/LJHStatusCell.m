//
//  LJHStatusCell.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHStatusCell.h"
#import "LJHStatus.h"
#import "LJHUser.h"
#import "LJHStatusFrame.h"
#import "LJHStatusToolBar.h"
#import "LJHStatusTopView.h"
@interface LJHStatusCell()
/** 顶部的view */
@property (weak, nonatomic) LJHStatusTopView *topView;
/** 微博的工具条 */
@property (weak, nonatomic) LJHStatusToolBar *statusToolBar;
@end


@implementation LJHStatusCell
/**
 @brief 这是一个代码自定义的cell的初始化类方法
 @param tableView 传进来的tableView
 @return 返回一个创建好了的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"status";
    LJHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LJHStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /**
         *  原创微博内部的子控件
         */
        [self setupOriginalStatusSubViews];
        /**
         *  微博的工具条
         */
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  原创微博内部的子控件
 */
- (void)setupOriginalStatusSubViews{
    self.backgroundColor = [UIColor clearColor];
    /**1.顶部的view */
    LJHStatusTopView *topView = [[LJHStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  微博的工具条
 */
- (void)setupStatusToolBar{
    /** 微博的工具条 */
    LJHStatusToolBar *statusToolBar = [[LJHStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}


/**
 *  拦截frame的设置,来设置cell的布局
 */

- (void)setFrame:(CGRect)frame{
    frame.origin.x = LJHStatusTableBorder;
    frame.origin.y += LJHStatusTableBorder;
    frame.size.height -= 2 * LJHStatusTableBorder;
    frame.size.width -= 2 * LJHStatusTableBorder;
    [super setFrame:frame];
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(LJHStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    /**
     *  原创微博
     */
    [self setupOriginalData];
    /**
     *  微博的工具条
     */
    [self setupToolBar];
}

- (void)setupOriginalData{

    //1.topView
    self.topView.frame = self.statusFrame.topViewF;

    //2.传递模型
    self.topView.statusFrame = self.statusFrame;
}

- (void)setupToolBar{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.status = self.statusFrame.status;
}

@end
