//
//  LJHComposeImageViews.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/19.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHComposeImageViews.h"
@interface LJHComposeImageViews()
@property (weak, nonatomic) UIButton *addButton;
@property (strong, nonatomic) NSMutableArray *photos;
@end

@implementation LJHComposeImageViews

- (NSMutableArray *)photos{
    if (_photos == nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupAddButton];
    }
    return self;

}

- (void)setupAddButton{
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setBackgroundImage:[UIImage imageWithName:@"compose_pic_add"] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageWithName:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
    addButton.frame = CGRectMake(0, 0, 90, 90);
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    self.addButton = addButton;
}

- (void)addButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(LJHComposeImageViewsDidTappedPlusButton)]) {
        [self.delegate LJHComposeImageViewsDidTappedPlusButton];
    }
}

- (NSArray *)totalImages{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.photos) {
        [array addObject:imageView.image];
    }
    return array;
}

- (void)addImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self.photos addObject:imageView];
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
    for (int index = 0; index < self.photos.count; index ++) {
            UIImageView *imageView = self.photos[index];
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
    
    /**
     *  决定+号按钮是否显示
     */
    if (self.photos.count == kMaxImgCount || self.photos.count == 0) {
        self.addButton.hidden = YES;
    }
    else
    {
        self.addButton.hidden = NO;
    }
    
    /**
     *  根据最后一张图片的位置来设置+号按钮的位置
     */
    if ([self.photos lastObject]) {
        UIImageView *lastImageView = [self.photos lastObject];
        CGFloat lastImageViewX = lastImageView.frame.origin.x;
        CGFloat lastImageViewY = lastImageView.frame.origin.y;
        if(lastImageViewX + (imageViewW * 2 + imageViewMargin) < CGRectGetMaxX(self.frame))
        {
            self.addButton.frame = CGRectMake(lastImageViewX + (imageViewW + imageViewMargin), lastImageViewY, imageViewW, imageViewH);
        }
        else
        {
            self.addButton.frame = CGRectMake(imageViewBorder, lastImageViewY + (imageViewH + imageViewMargin), imageViewW, imageViewH);
        }
    }
    
    
}

@end
