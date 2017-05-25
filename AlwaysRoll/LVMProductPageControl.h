//
//  LVMProductPageControl.h
//  LVMProductPageControl
//
//  Created by wurui on 17/5/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LVMProductPageControl : UIControl

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CGFloat circlePageDiameter;
@property (nonatomic, strong) UIFont *textFont;
/*
 选中点放大的比例
 */
@property (nonatomic, assign) CGFloat selectedPageScale;
//圆点的颜色
@property (nonatomic, strong) UIColor *unselectedDotPageColor;
@property (nonatomic, strong) UIColor *selectedDotPageColor;
//文字的颜色
@property (nonatomic, strong) UIColor *unselectedTextPageColor;
@property (nonatomic, strong) UIColor *selectedTextPageColor;
//底部视图的颜色
@property (nonatomic, strong) UIColor *bottomViewColor;
//底部视图的圆角
@property (nonatomic, assign) CGFloat bottomViewCornerRadius;
/*
 page圆心之间的距离
 */
@property (nonatomic, assign) CGFloat pageSpace;
/*
 距离左右留下的空隙
 */
@property (nonatomic, assign) CGFloat leftRightSpace;

- (void)changePage:(NSInteger)numberPage withFrame:(CGSize)size withText:(NSString *)text withImage:(NSString *)image;

@end
