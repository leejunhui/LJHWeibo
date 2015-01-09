//
//  LJHTabBar.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJHTabBar;
@protocol LJHTabBarDelegate<NSObject>
- (void)LJHTabBar:(LJHTabBar *)tabBar DidSelectTabBarButtonFrom:(int)from to:(int)to;
@end
@interface LJHTabBar : UIView
- (void)addTabBarItem:(UITabBarItem *)item;
@property (weak, nonatomic) id<LJHTabBarDelegate>delegate;
@end
