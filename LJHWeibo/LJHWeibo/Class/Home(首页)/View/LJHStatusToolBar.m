//
//  LJHStatusToolBar.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  微博cell底部工具条

#import "LJHStatusToolBar.h"
#import "LJHStatus.h"
@interface LJHStatusToolBar()
@property (strong, nonatomic) NSMutableArray *btns;
@property (strong, nonatomic) NSMutableArray *dividers;
@property (weak, nonatomic) UIButton *reweetBtn;
@property (weak, nonatomic) UIButton *commentBtn;
@property (weak, nonatomic) UIButton *attitudeBtn;
@end

@implementation LJHStatusToolBar

- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        //1.设置背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted" left:0.9 top:0.5];
        
        //2.添加按钮
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        //3.添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}
/**
 *  初始化分割线
 */
- (void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}


/**
 *  初始化按钮
 *
 *  @param title   按钮的文字
 *  @param image   按钮的小图标
 *  @param bgImage 按钮的背景
 */
- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

/**
 *  对子控件进行布局
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //1.设置按钮的frame
    int btnCount = (int)self.btns.count;
    CGFloat dividerW = 2;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / btnCount;
    CGFloat btnH = self.frame.size.height;
    for (int index = 0; index < btnCount; index ++) {
        UIButton *btn = self.btns[index];
        
        //设置frame
        CGFloat btnX = index * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    //2.设置分割线的frame
    CGFloat dividerH = btnH;
    
    CGFloat dividerY = 0;
    int dividerCount = (int)self.dividers.count;
    for (int j = 0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
    
        UIButton *button = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(button.frame);
        //设置frame
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

/**
 *  设置按钮上面的数据
 */
- (void)setStatus:(LJHStatus *)status{
    _status = status;
    
    //1.设置转发数
    [self setupBtn:self.reweetBtn count:status.reposts_count originalTitle:@"转发"];
    //2.设置评论数
    [self setupBtn:self.commentBtn count:status.comments_count originalTitle:@"评论"];
    //3.设置点赞数
    [self setupBtn:self.attitudeBtn count:status.attitudes_count originalTitle:@"赞"];
}


/**
 *  根据具体数据设置按钮
 *
 *  @param btn   按钮
 *  @param count 按钮对应的数据
 *  @param title 如果没有数据应该显示的文字
 */
- (void)setupBtn:(UIButton *)btn count:(int)count originalTitle:(NSString *)originalTitle{
    if (count) {
        if (count < 10000) {
            count = count;
            originalTitle = [NSString stringWithFormat:@"%d",count];
        }
        else if (count >= 10000)
        {
            double countDouble = count / 10000.0;
            originalTitle = [NSString stringWithFormat:@"%.1f万",countDouble];
            originalTitle = [originalTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:originalTitle forState:UIControlStateNormal];
}
@end
