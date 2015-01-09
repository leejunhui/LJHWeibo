//
//  UIImage+LJH.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LJH)
/**
 *  返回一张图片(自动适配iOS6/7)
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
@end
