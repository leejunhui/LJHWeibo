//
//  TextSizeTool.h
//  运动助理V1.1
//
//  Created by LiJunHui on 14/10/13.
//  Copyright (c) 2014年 Agents of Shield. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextSizeTool : NSObject
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
