//
//  LVMProductPageControl.m
//  LVMProductPageControl
//
//  Created by wurui on 17/5/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LVMProductPageControl.h"

static CGFloat const topAddDownSpace = 10;

@interface LVMProductPageControl ()

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UILabel *styleLabel;
@property (nonatomic, assign) NSInteger numberPage;
@property (nonatomic, strong) NSString *labelText;
@property (nonatomic, assign) CGSize pageSize;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSMutableArray *pageMutArr;

@end


@implementation LVMProductPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pageSpace = 10;
        self.currentPage = 0;
        self.leftRightSpace = 7;
        self.circlePageDiameter = 5;
        self.unselectedDotPageColor = [UIColor whiteColor];
        self.selectedDotPageColor = [UIColor grayColor];
        self.unselectedTextPageColor = [UIColor whiteColor];
        self.selectedTextPageColor = [UIColor grayColor];
        self.bottomViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.bottomViewCornerRadius = 7 / 15.0 * (self.circlePageDiameter + topAddDownSpace);
        self.textFont = [UIFont systemFontOfSize:10];
        self.selectedPageScale = 1;
        //        设值是防止修改第一个0点导致不调用方法
        self.numberPage = -1;
    }
    return self;
}

- (void)setupSubViews {
    CGFloat pageLength = 0;
    if (self.numberOfPages > 0) {
        pageLength = self.pageSpace * (self.numberOfPages - 1) + self.circlePageDiameter;
        pageLength += 2 * self.leftRightSpace;
    }
    if (self.pageMutArr.count >= 1) {
        //        循环获取有几个不同的label,然后增加背景View的长度
        for (int i = 0; i < self.pageMutArr.count; i++) {
            NSDictionary *pageDic = self.pageMutArr[i];
            CGSize pageSize = CGSizeFromString(pageDic[@"pageSize"]);
            pageLength += pageSize.width - self.circlePageDiameter;
        }
    }
    CGRect showViewFrame = CGRectMake(0.5 * (CGRectGetWidth(self.bounds) - pageLength), 0.5 * (CGRectGetHeight(self.bounds) - self.circlePageDiameter - topAddDownSpace), pageLength, self.circlePageDiameter + topAddDownSpace);
    self.showView.frame = showViewFrame;
    for (int i = 0 ; i < self.numberOfPages; i++) {
        if (i == _currentPage) {
            UILabel *circleLabel = [self viewWithTag:101 + _currentPage];
            circleLabel.backgroundColor = self.selectedDotPageColor;
            circleLabel.transform = CGAffineTransformMakeScale(self.selectedPageScale, self.selectedPageScale);
        } else {
            UILabel *circleLabel = [self viewWithTag:101 + i];
            circleLabel.backgroundColor = self.unselectedDotPageColor;
            circleLabel.transform = CGAffineTransformMakeScale(1, 1);
            for (int i = 0; i < self.pageMutArr.count; i++) {
                NSDictionary *pageDic = self.pageMutArr[i];
                NSInteger number = [pageDic[@"numberPage"] integerValue];
                self.styleLabel = [self viewWithTag:101 + number];
                self.styleLabel.textColor = self.unselectedTextPageColor;
                self.styleLabel.backgroundColor = [UIColor clearColor];
            }
        }
        //        循环设置每个不一样点的选择样式
        for (int i = 0; i < self.pageMutArr.count; i++) {
            NSDictionary *pageDic = self.pageMutArr[i];
            NSInteger number = [pageDic[@"numberPage"] integerValue];
            if (_currentPage == number) {
                self.styleLabel = [self viewWithTag:101 + _currentPage];
                self.styleLabel.textColor = self.selectedTextPageColor;
                self.styleLabel.backgroundColor = [UIColor clearColor];
                self.styleLabel.transform = CGAffineTransformMakeScale(1, 1);
            }
        }
    }
}

//一开始numberOfpage为0的时候
- (void)newTheFrame {
    for (int i = 0; i < self.pageMutArr.count; i++) {
        NSDictionary *pageDic = self.pageMutArr[i];
        [self setData:pageDic];
        int offsetPage = (int)self.numberPage + 1;
        self.styleLabel = [self viewWithTag:101 + self.numberPage];
        self.styleLabel.frame = CGRectMake(self.styleLabel.frame.origin.x, (self.circlePageDiameter + topAddDownSpace - self.pageSize.height) * 0.5, self.pageSize.width, self.pageSize.height);
        self.styleLabel.layer.cornerRadius = 0;
        self.styleLabel.text = self.labelText;
        self.styleLabel.textAlignment = NSTextAlignmentCenter;
        self.styleLabel.font = self.textFont;
        self.styleLabel.backgroundColor = [UIColor clearColor];
        if (self.image) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.styleLabel.bounds];
            imageView.image = [UIImage imageNamed:self.image];
            [self.styleLabel addSubview:imageView];
        }
        //        使不同的label后面的点产生偏移
        for (int i = offsetPage; i<self.numberOfPages; i++) {
            CGFloat offset = 0;
            if (self.pageSize.width != 0) {
                offset = self.pageSize.width - self.circlePageDiameter;
            }
            UILabel *circleLabel = [self viewWithTag:101 + i];
            CGRect frame = circleLabel.frame;
            frame.origin.x = circleLabel.frame.origin.x + offset;
            circleLabel.frame = frame;
        }
    }
}

//numberOfpage不为0，修改点一个个调用
- (void)newTheframe {
    NSInteger i = self.pageMutArr.count - 1;
    NSDictionary *pageDic = self.pageMutArr[i];
    [self setData:pageDic];
    int offsetPage = (int)self.numberPage + 1;
    self.styleLabel = [self viewWithTag:101 + self.numberPage];
    self.styleLabel.frame = CGRectMake(self.styleLabel.frame.origin.x, (self.circlePageDiameter + topAddDownSpace - self.pageSize.height) * 0.5, self.pageSize.width, self.pageSize.height);
    self.styleLabel.layer.cornerRadius = 0;
    self.styleLabel.text = self.labelText;
    self.styleLabel.textAlignment = NSTextAlignmentCenter;
    self.styleLabel.font = self.textFont;
    self.styleLabel.backgroundColor = [UIColor clearColor];
    if (self.image) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.styleLabel.bounds];
        imageView.image = [UIImage imageNamed:self.image];
        [self.styleLabel addSubview:imageView];
    }
    //        使不同的label后面的点产生偏移
    for (int i = offsetPage; i<self.numberOfPages; i++) {
        CGFloat offset = 0;
        if (self.pageSize.width != 0) {
            offset = self.pageSize.width - self.circlePageDiameter;
        }
        UILabel *circleLabel = [self viewWithTag:101 + i];
        CGRect frame = circleLabel.frame;
        frame.origin.x = circleLabel.frame.origin.x + offset;
        circleLabel.frame = frame;
    }
}

- (void)changePage:(NSInteger)numberPage withFrame:(CGSize)size withText:(NSString *)text withImage:(NSString *)image{
    if (text == nil) {
        text = @"";
    }
    if (image == nil) {
        image = @"";
    }
    if (_numberPage == numberPage) {
        return;
    }
    NSDictionary *pageDic = @{@"numberPage":@(numberPage),@"pageSize":NSStringFromCGSize(size),@"labelText":text,@"labelImage":image};
    [self.pageMutArr addObject:pageDic];
    if (_numberOfPages != 0) {
        [self newTheframe];
        [self setupSubViews];
    }
}

- (void)setData:(NSDictionary *)pageDic {
    self.numberPage = [pageDic[@"numberPage"] integerValue];
    self.pageSize = CGSizeFromString(pageDic[@"pageSize"]);
    self.labelText = pageDic[@"labelText"];
    self.image = pageDic[@"labelImage"];
}

#pragma mark  --- setter & getter
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] init];
        _showView.layer.cornerRadius = self.bottomViewCornerRadius;
        _showView.backgroundColor = self.bottomViewColor;
        [self addSubview:_showView];
    }
    return _showView;
}

- (NSMutableArray *)pageMutArr {
    if (!_pageMutArr) {
        _pageMutArr = [NSMutableArray array];
    }
    return _pageMutArr;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    if (_numberOfPages == numberOfPages) {
        return;
    }
    _numberOfPages = numberOfPages;
    for (int i = 0; i < self.numberOfPages; i++) {
        UILabel *circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftRightSpace + self.pageSpace * i, 0.5 * topAddDownSpace, self.circlePageDiameter, self.circlePageDiameter)];
        circleLabel.backgroundColor = [UIColor whiteColor];
        circleLabel.tag = 101 + i;
        circleLabel.layer.cornerRadius = self.circlePageDiameter / 2.0;
        circleLabel.clipsToBounds = YES;
        [self.showView addSubview:circleLabel];
    }
    if (self.pageMutArr != nil) {
        [self newTheFrame];
        [self setupSubViews];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    if (_numberOfPages != 0) {
        [self setupSubViews];
    }
}

@end
