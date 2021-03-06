//
//  ViewController.m
//  图片轮播器
//
//  Created by 赵鹏 on 15/5/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ViewController.h"
#import "ZPImageRotateScrollView.h"

@interface ViewController ()
@property (nonatomic, strong) ZPImageRotateScrollView *scrView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建图片轮播器对象
    UIImage *img = [UIImage imageNamed:@"img_01"];
    CGFloat scrW = img.size.width * 0.5;
    CGFloat scrH = img.size.height * 0.5;
    CGFloat scrX = ([UIScreen mainScreen].bounds.size.width - scrW) * 0.5;
    CGFloat scrY = 20;
    //设置frame
    CGRect frame = CGRectMake(scrX,scrY,scrW,scrH);
    
    self.scrView = [[ZPImageRotateScrollView alloc]initWithFrame:frame];

    self.scrView.duration = 1.5;
    //设置滚动方向
    self.scrView.ScrollDiraction = ScrollDiractionRight;
    //设置其他指示器点颜色
    self.scrView.otherIndicatorColor = [UIColor blueColor];
    //设置当前指示器点颜色
    self.scrView.currentPageIndicatorColor = [UIColor redColor];
    //将需要播放的图片放入picArr数组中
    self.scrView.picArr = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    [self.view addSubview:self.scrView];
}



@end
