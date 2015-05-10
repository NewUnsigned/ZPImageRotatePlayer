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
    self.scrView = [[ZPImageRotateScrollView alloc]init];
    UIImage *img = [UIImage imageNamed:@"img_01"];
    CGFloat scrW = img.size.width * 0.5;
    CGFloat scrH = img.size.height *0.5;
    CGFloat scrX = ([UIScreen mainScreen].bounds.size.width - scrW) * 0.5;
    CGFloat scrY = 20;
    self.scrView.frame = CGRectMake(scrX,scrY,scrW,scrH);
    self.scrView.picArr = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    [self.view addSubview:self.scrView];
}



@end
