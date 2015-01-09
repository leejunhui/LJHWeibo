//
//  LJHNewFeatureController.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LJHNewfeatureController.h"
#import "LJHTabBarController.h"
#define LJHNewfeatureControllerImageCount 3
@interface LJHNewFeatureController()<UIScrollViewDelegate>
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation LJHNewFeatureController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    //0.设置背景颜色
    //    self.view.backgroundColor = LJHColor(246, 246, 246);
    
    /**
     *  添加scrollView
     */
    [self setupScrollView];
    
    /**
     *  添加pageControl
     */
    [self setupPageControl];
    
}

/**
 *  添加pageControl
 */
- (void)setupPageControl{
    
    //添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = LJHNewfeatureControllerImageCount;
    pageControl.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 30);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    //设置圆点颜色
    pageControl.currentPageIndicatorTintColor = LJHColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = LJHColor(189, 189, 189);
    
}

/**
 *  添加ScrollView
 */
- (void)setupScrollView
{
    //1.添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    //2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int i = 0; i < LJHNewfeatureControllerImageCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        //设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageWithName:name];
        
        //设置frame
        CGFloat imageX = imageW * i;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        
        if (i == LJHNewfeatureControllerImageCount - 1) {
            [self setupStartButtonWithImageView:imageView];
        }
    }
    
    //3.设置滚动内容尺寸
    scrollView.contentSize = CGSizeMake(LJHNewfeatureControllerImageCount * scrollView.frame.size.width, scrollView.frame.size.height);
}

- (void)setupStartButtonWithImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled = YES;
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton setTitle:@"进入微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat startButtonW = startButton.currentBackgroundImage.size.width;
    CGFloat startButtonH = startButton.currentBackgroundImage.size.height;
    CGFloat startButtonX = imageView.frame.size.width * 0.5 - startButtonW * 0.5;
    CGFloat startButtonY = imageView.frame.size.height * 0.6;
    
    startButton.frame = CGRectMake(startButtonX, startButtonY, startButtonW, startButtonH);
    [startButton addTarget:self action:@selector(startBtn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBox.selected = YES;
    [checkBox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkBox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkBoxCenterX = imageView.frame.size.width * 0.5;
    CGFloat checkBoxCenterY = imageView.frame.size.height * 0.5;
    checkBox.center = CGPointMake(checkBoxCenterX, checkBoxCenterY);
    checkBox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    checkBox.titleLabel.font = [UIFont systemFontOfSize:19];
    [checkBox addTarget:self action:@selector(checkBox:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBox];
    
}

- (void)checkBox:(UIButton *)button
{
    button.selected = !button.isSelected;
}

- (void)startBtn{
    //显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[LJHTabBarController alloc] init];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX / scrollView.frame.size.width;
    int currentPage = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = currentPage;
}

@end
