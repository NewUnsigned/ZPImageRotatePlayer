# ZPImageRotatePlayer
一个简单的图片轮播器
```objc
    //创建图片轮播器对象
    self.scrView = [[ZPImageRotateScrollView alloc]init];
    UIImage *img = [UIImage imageNamed:@"img_01"];
    CGFloat scrW = img.size.width * 0.5;
    CGFloat scrH = img.size.height * 0.5;
    CGFloat scrX = ([UIScreen mainScreen].bounds.size.width - scrW) * 0.5;
    CGFloat scrY = 20;
    //设置frame
    self.scrView.frame = CGRectMake(scrX,scrY,scrW,scrH);
    //设置播放间隔
    self.scrView.duration = 1.0;
    //设置滚动方向
    self.scrView.ScrollDiraction = ScrollDiractionRight;
    //设置其他指示器点颜色
    self.scrView.otherIndicatorColor = [UIColor blueColor];
    //设置当前指示器点颜色
    self.scrView.currentPageIndicatorColor = [UIColor redColor];
    //将需要播放的图片放入picArr数组中
    //图片名称可以随意
    self.scrView.picArr = @[@"img_01",@"img_02",@"img_03",@"img_04",@"img_05"];
    [self.view addSubview:self.scrView];
```
