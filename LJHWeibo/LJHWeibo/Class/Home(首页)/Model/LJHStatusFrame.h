//
//  LJHStatusFrame.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  一个cell对应一个LJHStatusFrame对象

#import <Foundation/Foundation.h>
/**cell的边框宽度 */
#define LJHStatusCellBorder 10
/**昵称字体 */
#define LJHStatusNameFont [UIFont systemFontOfSize:15]
/**被转发微博作者字体 */
#define LJHRetweetStatusNameFont LJHStatusNameFont
/**时间字体 */
#define LJHStatusTimeFont [UIFont systemFontOfSize:11]
/**来源字体 */
#define LJHStatusSourceFont LJHStatusTimeFont
/**正文字体 */
#define LJHStatusContentFont [UIFont systemFontOfSize:15]
/**被转发正文字体 */
#define LJHRetweetStatusContentFont LJHStatusContentFont

/** 表格的边框宽度 */
#define LJHStatusTableBorder 5

@class LJHStatus;
@interface LJHStatusFrame : NSObject
@property (strong, nonatomic) LJHStatus *status;

/** 顶部的view */
@property (assign, nonatomic, readonly) CGRect topViewF;
/** 头像 */
@property (assign, nonatomic, readonly) CGRect iconViewF;
/** 会员图标 */
@property (assign, nonatomic, readonly) CGRect vipViewF;
/** 配图 */
@property (assign, nonatomic, readonly) CGRect photoViewF;
/** 昵称 */
@property (assign, nonatomic, readonly) CGRect nameLabelF;
/** 时间 */
@property (assign, nonatomic, readonly) CGRect timeLabelF;
/** 来源 */
@property (assign, nonatomic, readonly) CGRect sourceLabelF;
/** 正文 */
@property (assign, nonatomic, readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (assign, nonatomic, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (assign, nonatomic, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文 */
@property (assign, nonatomic, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (assign, nonatomic, readonly) CGRect retweetPhotoViewF;

/** 微博的工具条 */
@property (assign, nonatomic, readonly) CGRect statusToolBarF;

/** cell的高度 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;
@end
