//
//  LJHComposeImageViews.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/19.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHComposeImageViews.h"

@interface LJHComposeImageViews()
@end

@implementation LJHComposeImageViews


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;

}

- (NSArray *)totalImages{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}

- (void)addImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imageViewX,imageViewY;
    CGFloat imageViewW = 90;
    CGFloat imageViewH = imageViewW;
    int maxColumns = 3;
    CGFloat imageViewBorder = 20;
    CGFloat imageViewMargin = (self.frame.size.width - maxColumns * imageViewW - imageViewBorder * 2) / (maxColumns - 1);
    LJHLog(@"%f %f",imageViewBorder,imageViewMargin);
    for (int index = 0; index < self.subviews.count; index ++) {
        UIImageView *imageView = self.subviews[index];
        int row = index / maxColumns;
        int col = index % maxColumns;
        if (col == 0) {
             imageViewX = imageViewBorder;
        }
        else
        {
            imageViewX = imageViewBorder + (imageViewW + imageViewMargin) * col;
        }
        
         imageViewY = (imageViewH + imageViewMargin) * row;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}

@end
