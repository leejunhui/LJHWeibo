//
//  LJHStatusToolBar.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHStatusToolBar.h"

@implementation LJHStatusToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted" left:0.9 top:0.5];
    }
    return self;
}

@end
