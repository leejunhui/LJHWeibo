//
//  LJHComposeToolBar.h
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/19.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJHComposeToolBar;

typedef enum {
    LJHComposeToolbarButtonTypeCamera,
    LJHComposeToolbarButtonTypePicture,
    LJHComposeToolbarButtonTypeMention,
    LJHComposeToolbarButtonTypeTrend,
    LJHComposeToolbarButtonTypeEmotion
} LJHComposeToolbarButtonType;

@protocol LJHComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(LJHComposeToolBar *)toolbar didClickedButton:(LJHComposeToolbarButtonType)buttonType;
@end

@interface LJHComposeToolBar : UIView
@property (weak, nonatomic) id<LJHComposeToolbarDelegate> delegate;
@end
