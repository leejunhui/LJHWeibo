//
//  LJHComposeImageViews.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/19.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJHComposeImageViews;
@protocol LJHComposeImageViewsDelegate <NSObject>

@optional
- (void)LJHComposeImageViewsDidTappedPlusButton;
@end

@interface LJHComposeImageViews : UIView
/**
 *  添加照片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回所有的图片
 */
- (NSArray *)totalImages;

@property (weak, nonatomic)id<LJHComposeImageViewsDelegate>delegate;
@end
