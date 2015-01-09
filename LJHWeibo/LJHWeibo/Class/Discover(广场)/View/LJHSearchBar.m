//
//  LJHSearchBar.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHSearchBar.h"

@implementation LJHSearchBar
+ (instancetype)searchBar{
    return [[LJHSearchBar alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackground:[UIImage resizedImageWithName:@"searchbar_textfield_background"]];
        
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        leftView.contentMode = UIViewContentModeCenter;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = leftView;
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        self.font = [UIFont systemFontOfSize:13];
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
}
@end
