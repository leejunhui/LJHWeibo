//
//  LJHTextSizeTool.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJHTextSizeTool : NSObject
/**
 *  根据传进来的文本，字体，和最大的大小进行计算合适的大小
 *
 *  @param text    文本
 *  @param font    字体
 *  @param maxSize 所允许的最大大小
 *
 *  @return 合适的文本大小
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
@end
