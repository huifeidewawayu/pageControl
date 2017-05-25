//
//  AlwaysRollView.m
//  AlwaysRoll
//
//  Created by wurui on 17/3/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AlwaysRollView.h"
#import "LVMProductPageControl.h"

#define kAlwaysRollViewWidth self.frame.size.width
#define kAlwaysRollViewHeight self.frame.size.height

static CGFloat const pageViewHeight = 30.f;
@interface AlwaysRollView () <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *alwaysRoll;
@property (nonatomic, strong)LVMProductPageControl *pageView;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation AlwaysRollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.alwaysRoll];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timingRoll:) userInfo:nil repeats:YES];
    return self;
}

//定时器方法
- (void)timingRoll:(NSTimer *)timer {
    //使当前所在的位置加1
    NSInteger value = self.alwaysRoll.contentOffset.x / kAlwaysRollViewWidth + 1;
    //偏移到下一张图片
    self.alwaysRoll.contentOffset = CGPointMake(value * kAlwaysRollViewWidth, 0);
    self.pageView.currentPage = [self pageValue];
    if (self.alwaysRoll.contentOffset.x == self.alwaysRoll.contentSize.width - kAlwaysRollViewWidth) {
        self.alwaysRoll.contentOffset = CGPointMake(kAlwaysRollViewWidth, 0);
        self.pageView.currentPage = [self pageValue];
    }
}

#pragma mark  --- get && set
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.alwaysRoll.contentSize = CGSizeMake(_imageArray.count * kAlwaysRollViewWidth, kAlwaysRollViewHeight);
    for (int i = 0; i<_imageArray.count; i++) {
        UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kAlwaysRollViewWidth, 0, kAlwaysRollViewWidth, kAlwaysRollViewHeight)];
        showImageView.image = [UIImage imageNamed:_imageArray[i]];
        [self.alwaysRoll addSubview:showImageView];
    }
//    [self.pageView changePage:1 withFrame:CGSizeMake(21.5, 10) withText:@"嘻嘻" withImage:nil];
//    [self.pageView changePage:2 withFrame:CGSizeMake(10, 10) withText:@"哈" withImage:nil];

    self.pageView.numberOfPages = _imageArray.count - 2;
}

- (void)setIsPageView:(BOOL)isPageView {
    _isPageView = isPageView;
    if (isPageView) {
        [self addSubview:self.pageView];
    }
}

- (UIScrollView *)alwaysRoll {
    if (!_alwaysRoll) {
        _alwaysRoll = [[UIScrollView alloc] init];
        _alwaysRoll.frame = CGRectMake(0, 0, kAlwaysRollViewWidth, kAlwaysRollViewHeight);
        _alwaysRoll.bounces = NO;
        _alwaysRoll.showsHorizontalScrollIndicator = NO;
        _alwaysRoll.contentOffset = CGPointMake(kAlwaysRollViewWidth, 0);
        _alwaysRoll.pagingEnabled = YES;
        _alwaysRoll.delegate = self;
    }
    return _alwaysRoll;
}

- (LVMProductPageControl *)pageView {
    if (!_pageView) {
        _pageView = [[LVMProductPageControl alloc] init];
        _pageView.frame = CGRectMake(0, kAlwaysRollViewHeight - pageViewHeight, kAlwaysRollViewWidth, pageViewHeight);
        _pageView.selectedPageScale = 1.4;
//        _pageView.unselectedDotPageColor = [UIColor cyanColor];
//        _pageView.selectedDotPageColor = [UIColor orangeColor];
        [_pageView changePage:3 withFrame:CGSizeMake(21.5, 10) withText:@"囍哈" withImage:nil];
        _pageView.textFont = [UIFont systemFontOfSize:9];
    }
    return _pageView;
}

#pragma mark  --- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageView.currentPage = [self pageValue];
    //判断是否偏移到了最后一张图
    if (self.alwaysRoll.contentOffset.x == self.alwaysRoll.contentSize.width - kAlwaysRollViewWidth) {
        self.alwaysRoll.contentOffset = CGPointMake(kAlwaysRollViewWidth, 0);
        self.pageView.currentPage = [self pageValue];
    }else if (self.alwaysRoll.contentOffset.x == 0) {
        //滑动到倒数第二张图
        self.alwaysRoll.contentOffset = CGPointMake(self.alwaysRoll.contentSize.width -  2 * kAlwaysRollViewWidth, 0);
        self.pageView.currentPage = [self pageValue];
    }
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(timingRoll:) userInfo:nil repeats:YES];
    }
}

//计算滑动第几页
- (NSInteger)pageValue {
    return self.alwaysRoll.contentOffset.x / kAlwaysRollViewWidth - 1;
}

@end
