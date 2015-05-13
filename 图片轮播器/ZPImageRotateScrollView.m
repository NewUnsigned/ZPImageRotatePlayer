//
//  ZPImageRotateScrollView.m
//  图片轮播器
//
//  Created by 赵鹏 on 15/5/10.
//  Copyright (c) 2015年 赵鹏. All rights reserved.
//

#import "ZPImageRotateScrollView.h"

#define ZP_PageControl_Location 0.94



@interface ZPImageRotateScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;        // 页面指示器
@property (nonatomic,strong)  UIScrollView  *scrollView;         // 图片滚动视图
@property (nonatomic,weak)    UIImageView   *currentImageView;   // 当前imageView
@property (nonatomic,weak)    UIImageView   *nextImageView;      // 下一个imageView
@property (nonatomic,weak)    UIImageView   *preImageView;       // 上一个imageView
@property (nonatomic,strong)  NSTimer       *timer;              // 设置动画
@property (nonatomic, assign) NSUInteger     currentPicIndex;    // 当前展示的是第几张图片;
@property (nonatomic,assign)  BOOL           isDragging;         // 是否正在拖动
@end

@implementation ZPImageRotateScrollView



- (void)setPicArr:(NSArray *)picArr
{
    _picArr = picArr;
    [self setPicsAndTimer];
    [self setPageControl];
}

- (void)setPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = self.picArr.count;
    //非当前图片的页面指示器圆点颜色
    if (_otherIndicatorColor) {
        pageControl.pageIndicatorTintColor = _otherIndicatorColor;
    }
    if (_currentPageIndicatorColor) {
        pageControl.currentPageIndicatorTintColor = _currentPageIndicatorColor;
    }
    CGFloat pageW = pageControl.frame.size.width;
    CGFloat pageH = pageControl.frame.size.height;
    CGFloat pageX = (self.frame.size.width - pageW) * 0.5;
    CGFloat pageY = self.frame.size.height * ZP_PageControl_Location;
    pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

//图片数量
NSUInteger COUNT = 0;
- (void)setPicsAndTimer
{
    self.scrollView = [[UIScrollView alloc]init];
    [self addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    COUNT = self.picArr.count - 1;
    if (COUNT == 0) return;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(width * 3, height)];
    //  设置隐藏横向条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //  设置自动分页
    self.scrollView.pagingEnabled = YES;
    //  设置当前点
    self.scrollView.contentOffset = CGPointMake(width, 0);
    self.scrollView.delegate = self;
    //  设置是否有边界
    self.scrollView.bounces = NO;
    
    //  初始化当前视图
    UIImageView *currentImageView =[[UIImageView alloc] init];
    currentImageView.image = [UIImage imageNamed:self.picArr[0]];
    [self.scrollView addSubview:currentImageView];
    self.currentImageView = currentImageView;
    self.currentImageView.frame = CGRectMake(width, 0, width, height);
    self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;

    //  初始化下一个视图
    UIImageView *nextImageView = [[UIImageView alloc] init];
    nextImageView.image = [UIImage imageNamed:self.picArr[1]];
    [self.scrollView addSubview:nextImageView];
    self.nextImageView = nextImageView;
    self.nextImageView.frame = CGRectMake(width * 2, 0, width, height);
    self.nextImageView.contentMode = UIViewContentModeScaleAspectFill;
    //  初始化上一个视图
    UIImageView *preImageView =[[UIImageView alloc] init];
    preImageView.image = [UIImage imageNamed:self.picArr.lastObject];
    preImageView.frame = CGRectMake(0, 0, width, height);
    [self.scrollView addSubview:preImageView];
    self.preImageView = preImageView;
    self.preImageView.contentMode =UIViewContentModeScaleAspectFill;
    self.pageControl.currentPage = self.currentPicIndex;

    //  设置时钟动画 定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(update:) userInfo:nil repeats:YES];
    //  将定时器添加到主线程
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)update:(NSTimer *)timer{
    //定时移动
    if (_isDragging == YES) return;
    CGPoint offSet = self.scrollView.contentOffset;
    if (!_ScrollDiraction) _ScrollDiraction = ScrollDiractionLeft;
    offSet.x += offSet.x * _ScrollDiraction;
    [self.scrollView setContentOffset:offSet animated:YES];
    
    if (offSet.x >= self.frame.size.width * 2) {
        offSet.x = self.frame.size.width;
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
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset = self.scrollView.contentOffset.x;
    if (self.nextImageView.image == nil || self.preImageView.image == nil) {
        //  加载下一个视图
        NSString *imageName1 = self.picArr[_currentPicIndex == COUNT? 0:_currentPicIndex + 1];
        _nextImageView.image = [UIImage imageNamed:imageName1];
        // 加载上一个视图
        NSString *imageName2 = self.picArr[_currentPicIndex == 0 ? COUNT:_currentPicIndex - 1];
        _preImageView.image = [UIImage imageNamed:imageName2];
    }
    if(offset == 0){
        _currentImageView.image = _preImageView.image;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _preImageView.image = nil;
        if (_currentPicIndex == 0) {
            _currentPicIndex = COUNT;
        } else{
            _currentPicIndex -= 1;
        }
    }
    if (offset == scrollView.bounds.size.width * 2) {
        _currentImageView.image = _nextImageView.image;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _nextImageView.image = nil;
        if (_currentPicIndex == COUNT) {
            _currentPicIndex  = 0;
        }else{
            _currentPicIndex += 1;
        }
    }
    self.pageControl.currentPage = self.currentPicIndex;
}

@end
