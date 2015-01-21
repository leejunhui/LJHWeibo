//
//  Common.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/18.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#ifndef LJHWeibo_Common_h
#define LJHWeibo_Common_h

#import <AFNetworking.h>
#import "UIImage+LJH.h"
#import "UIBarButtonItem+LJH.h"
#import "LJHTextSizeTool.h"
#import <UIImageView+WebCache.h>
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "LJHHttpTool.h"
#import "LJHBaseParam.h"

//判断是否是iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//取色
#define LJHColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//自定义日志输出
#ifdef DEBUG
#define LJHLog(...) NSLog(__VA_ARGS__)
#else
#define LJHLog(...)
#endif



#define LJHNotificationCenter [NSNotificationCenter defaultCenter]

#define kMaxImgCount 9

//授权的appID
#define OAuthAppID @"3269275577"
//授权的appKey
#define OAuthAppKey @"3b2bc1dfc47d8b6600bcefd228bb4704"
//授权的回调地址
#define OAuthRedirectURL @"http://www.baidu.com"
//请求的类型
#define OAuthGrantType @"authorization_code"
//登录的URL
#define LoginURLString [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",OAuthAppID,OAuthRedirectURL]

//保存账户信息的沙盒地址
#define LJHAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

//新特性界面图片的个数
#define LJHNewfeatureControllerImageCount 3

//tabBar按钮图片高度所占的百分比
#define LJHTabBarButtonImageRatio 0.7

/**首页用户名称右边箭头图标的宽度 */
#define LJHTitleButtonImageW 20

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
/**计算文字高度时用的的最大大小*/
#define LJHStatusMaxSize CGSizeMake(MAXFLOAT, MAXFLOAT)

/** 表格的边框宽度 */
#define LJHStatusTableBorder 5

/**微博配图的宽度 */
#define IWPhotoW 70
/**微博配图的高度 */
#define IWPhotoH 70
/**微博配图之间的间距 */
#define IWPhotoMargin 10

#endif
