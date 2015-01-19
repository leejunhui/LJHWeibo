//
//  LJHComposeImageViews.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/19.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJHComposeImageViews : UIView
/**
 *  添加照片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回所有的图片
 */
- (NSArray *)totalImages;
@end
