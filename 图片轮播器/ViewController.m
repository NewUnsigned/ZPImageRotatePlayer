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
    self.scrView.frame = CGRectMake(0, 0, img.size.width * 0.5, img.size.height * 0.5);
    self.scrView.picArr = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    [self.view addSubview:self.scrView];
}



@end
