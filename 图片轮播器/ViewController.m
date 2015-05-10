//
//  ViewController.m
//  图片轮播器
//
//  Created by 赵鹏 on 15/5/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ViewController.h"

static NSUInteger KOUNT = 5;

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *currentImageView;   // 当前imageView
@property (nonatomic,weak) UIImageView *nextImageView;      // 下一个imageView
@property (nonatomic,weak) UIImageView *preImageView;       //上一个imageView
@property (nonatomic,assign) BOOL isDragging;               //是否正在拖动
@property (nonatomic,strong)NSTimer *timer;                 //设置动画
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView *scrollView =[[UIScrollView alloc] init];
    CGFloat width = 300 ;
    CGFloat height = 130;
    scrollView.frame = CGRectMake(0, 0, width, height);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [self.scrollView setContentSize:CGSizeMake(width * 3, height)];
    //  设置隐藏横向条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //  设置自动分页
    self.scrollView.pagingEnabled = YES;
    //  设置代理
    self.scrollView.delegate = self;
    //  设置当前点
    self.scrollView.contentOffset = CGPointMake(width, 0);
    //  设置是否有边界
    self.scrollView.bounces = NO;
    //  初始化当前视图
    UIImageView *currentImageView =[[UIImageView alloc] init];
    currentImageView.image = [UIImage imageNamed:@"img_01"];
    [self.scrollView addSubview:currentImageView];
    self.currentImageView = currentImageView;
    self.currentImageView.frame = CGRectMake(width, 0, width, height);
    self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  初始化下一个视图
    UIImageView *nextImageView = [[UIImageView alloc] init];
    nextImageView.image = [UIImage imageNamed:@"img_02"];
    [self.scrollView addSubview:nextImageView];
    self.nextImageView = nextImageView;
    self.nextImageView.frame = CGRectMake(width * 2, 0, width, height);
    self.nextImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  初始化上一个视图
    UIImageView *preImageView =[[UIImageView alloc] init];
    preImageView.image = [UIImage imageNamed:@"img_03"];
    preImageView.frame = CGRectMake(0, 0, width, height);
    [self.scrollView addSubview:preImageView];
    self.preImageView = preImageView;
    self.preImageView.contentMode =UIViewContentModeScaleAspectFill;
    
    //  设置时钟动画 定时器
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    //  将定时器添加到主线程
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)update:(NSTimer *)timer{
    //定时移动
    
    if (_isDragging == YES) {
        return ;
    }
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x +=offSet.x;
    [self.scrollView setContentOffset:offSet animated:YES];
    
    if (offSet.x >= self.view.frame.size.width *2) {
        offSet.x = self.view.frame.size.width;
    }
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isDragging = YES;
}
//  停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isDragging = NO;
//    step = 0;
}

// 开始拖动
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    static NSUInteger i =1; //   当前展示的是第几张图片
    float offset = self.scrollView.contentOffset.x;
    if (self.nextImageView.image == nil || self.preImageView.image == nil) {
        //  加载下一个视图
        NSString *imageName1 = [NSString stringWithFormat:@"img_0%ld",i == KOUNT ? 1:i +1];
        _nextImageView.image = [UIImage imageNamed:imageName1];
        // 加载上一个视图
        NSString *imageName2 = [NSString stringWithFormat:@"img_0%ld",i==1 ? KOUNT :i-1];
        _preImageView.image = [UIImage imageNamed:imageName2];
    }
    if(offset ==0){
        _currentImageView.image = _preImageView.image;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _preImageView.image = nil;
        if (i == 1) {
            i = KOUNT;
        } else{
            i-=1;
        }
    }
    if (offset == scrollView.bounds.size.width * 2) {
        _currentImageView.image = _nextImageView.image;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _nextImageView.image = nil;
        if (i == KOUNT) {
            i  =1 ;
        }else{
            i +=1 ;
        }
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
