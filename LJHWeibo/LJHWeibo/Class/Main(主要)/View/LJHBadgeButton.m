
//
//  LJHBadgeButton.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHBadgeButton.h"

@implementation LJHBadgeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.hidden = YES;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    
    if(badgeValue)
    {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGRect buttonFrame = self.frame;
        CGSize textSize = [badgeValue sizeWithFont:self.titleLabel.font];
        buttonFrame.size.width = textSize.width + 10;
        buttonFrame.size.height = self.currentBackgroundImage.size.height;
        self.frame = buttonFrame;
    }
    else
    {
        self.hidden = YES;
    }
 
}

@end
