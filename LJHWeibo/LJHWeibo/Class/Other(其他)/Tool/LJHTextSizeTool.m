//
//  LJHTextSizeTool.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHTextSizeTool.h"
@implementation LJHTextSizeTool
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    if(iOS7)
    {
        NSDictionary *attrs = @{NSFontAttributeName : font};
        return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }
    else
    {
#warning iOS7之前
       return  [text sizeWithFont:font constrainedToSize:maxSize];
    }
}
@end
