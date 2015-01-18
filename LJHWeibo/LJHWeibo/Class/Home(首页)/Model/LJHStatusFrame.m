//
//  LJHStatusFrame.m
//  LJHWeibo
//
//  Created by LeeJunHui on 15/1/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//  一个cell对应一个LJHStatusFrame对象

#import "LJHStatusFrame.h"
#import "LJHStatus.h"
#import "LJHUser.h"
#import "LJHPhoto.h"
#import "LJHPhotosView.h"
@implementation LJHStatusFrame

/**
 *  获取微博数据模型之后，根据微博数据计算子控件frame
 */
- (void)setStatus:(LJHStatus *)status{
    _status = status;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - LJHStatusTableBorder * 2;
    
    //1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    //2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = LJHStatusCellBorder;
    CGFloat iconViewY = LJHStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + LJHStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [TextSizeTool sizeWithText:status.user.name font:LJHStatusNameFont maxSize:LJHStatusMaxSize];
//    CGSize nameLabelSize = [status.user.name sizeWithFont:LJHStatusNameFont];
    _nameLabelF = (CGRect){{nameLabelX,nameLabelY}, nameLabelSize};
    
    //4.会员图标
    if (status.user.mbtype > 2)
    {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF)+ LJHStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + LJHStatusCellBorder * 0.5;
    CGSize timeLabelSize = [TextSizeTool sizeWithText:status.created_at font:LJHStatusTimeFont maxSize:LJHStatusMaxSize];
//    CGSize timeLabelSize = [status.created_at sizeWithFont:LJHStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX,timeLabelY}, timeLabelSize};
    
    //6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + LJHStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [TextSizeTool sizeWithText:status.source font:LJHStatusSourceFont maxSize:LJHStatusMaxSize];
//    CGSize sourceLabelSize = [status.source sizeWithFont:LJHStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX,sourceLabelY}, sourceLabelSize};
    
    //7.正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF),CGRectGetMaxY(_iconViewF)) + LJHStatusCellBorder * 0.5;
    CGFloat contentLabelMaxW = topViewW - 2 * LJHStatusCellBorder;
    CGSize contentLabelSize = [TextSizeTool sizeWithText:status.text font:LJHStatusContentFont maxSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
//    CGSize contentLabelSize = [status.text sizeWithFont:LJHStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY}, contentLabelSize};
    
    //8.配图
    if (status.pic_urls.count)
    {
        //根据图片的个数计算整个相册的尺寸
        CGSize photosViewSize = [LJHPhotosView photosViewSizeWithPhotosCount:(int)status.pic_urls.count];
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + LJHStatusCellBorder;
        _photosViewF = CGRectMake(photoViewX, photoViewY, photosViewSize.width, photosViewSize.height);
    }
    
    //9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = topViewW - 2 * LJHStatusCellBorder * 0.5;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + LJHStatusCellBorder;
        CGFloat retweetViewH = 0;
        
        //10.被转发微博昵称
        CGFloat retweetNameLabelX = LJHStatusCellBorder;
        CGFloat retweetNameLabelY = LJHStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [TextSizeTool sizeWithText:name font:LJHRetweetStatusNameFont maxSize:LJHStatusMaxSize];
//        CGSize retweetNameLabelSize = [name sizeWithFont:LJHRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX,retweetNameLabelY}, retweetNameLabelSize};
        
        //11.被转发微博正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + LJHStatusCellBorder * 0.5;
        CGSize retweetContentLabelMaxSize = CGSizeMake(retweetViewW - 2 * LJHStatusCellBorder, MAXFLOAT);
        CGSize retweetContentLabelSize = [TextSizeTool sizeWithText:status.retweeted_status.text font:LJHRetweetStatusContentFont maxSize:retweetContentLabelMaxSize];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY}, retweetContentLabelSize};
   
        //12.被转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
            //根据图片的个数计算整个相册的尺寸
            CGSize retweetPhotosViewSize = [LJHPhotosView photosViewSizeWithPhotosCount:(int)status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + LJHStatusCellBorder;
            _retweetPhotosViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
        }
        else { //没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += LJHStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    }
    else
    {
        //没有转发微博是topViewH
        if (status.pic_urls.count) { //有图
            topViewH = CGRectGetMaxY(_photosViewF);
        }
        else { //无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += LJHStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //13.工具条
    CGFloat statusToolBarX = topViewX;
    CGFloat statusToolBarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolBarW = topViewW;
    CGFloat statusToolBarH = 35;
    _statusToolBarF = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    //14.计算cell高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + LJHStatusTableBorder * 2;
}

@end
