//
//  ZPImageRotateScrollView.h
//  图片轮播器
//
//  Created by 赵鹏 on 15/5/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ScrollDiractionLeft = 1,
    ScrollDiractionRight = -1,
    
}ScrollDiractionType;

@interface ZPImageRotateScrollView : UIView
///  存放将要播放图片的数组
@property (nonatomic, strong) NSArray *picArr;
///  图片轮播间隔
@property (nonatomic, assign) double duration;
///  图片轮播器滚动方向
@property (nonatomic, assign) ScrollDiractionType ScrollDiraction;
///  非当前图片指示器颜色
@property (nonatomic, strong) UIColor *otherIndicatorColor;
///  当前页面指示器颜色
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;
@end
