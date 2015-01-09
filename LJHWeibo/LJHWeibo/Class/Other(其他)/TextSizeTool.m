//
//  TextSizeTool.m
//  运动助理V1.1
//
//  Created by LiJunHui on 14/10/13.
//  Copyright (c) 2014年 Agents of Shield. All rights reserved.
//

#import "TextSizeTool.h"

@implementation TextSizeTool

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
