//
//  LJHPhotosView.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/15.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJHPhotosView : UIView
/**
 *  需要展示的图片(数组里面都是LJHPhoto模型)
 */
@property (strong, nonatomic) NSArray *photos;
/**
*  根据图片的个数返回相册的最终尺寸
*/
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
