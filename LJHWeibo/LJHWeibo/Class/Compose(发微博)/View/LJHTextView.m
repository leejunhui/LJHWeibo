//
//  LJHTextView.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/18.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHTextView.h"
@interface LJHTextView()
@property (weak, nonatomic) UILabel *placeholderLabel;
@end
@implementation LJHTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupPlaceholder];
        
        [self setupNotificationCenter];
    }
    return self;
}

- (void)setupPlaceholder{
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.font = self.font;
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.hidden = YES;
    placeholderLabel.textColor = [UIColor lightGrayColor];
    [self insertSubview:placeholderLabel atIndex:0];
    self.placeholderLabel = placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
        
        CGFloat labelX = 5;
        CGFloat labelY = 7;
        CGFloat maxW = self.frame.size.width - labelX * 2;
        CGFloat maxH = self.frame.size.height - labelY * 2;
        CGSize maxSize = [LJHTextSizeTool sizeWithText:placeholder font:self.placeholderLabel.font maxSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = CGRectMake(labelX, labelY, maxSize.width, maxSize.height);
    }
    else{
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}

- (void)setupNotificationCenter{
    [LJHNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)textChange{
    self.placeholderLabel.hidden = !(self.text.length == 0);
}

- (void)dealloc{
    [LJHNotificationCenter removeObserver:self];
}

@end
