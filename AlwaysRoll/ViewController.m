//
//  ViewController.m
//  AlwaysRoll
//
//  Created by wurui on 17/3/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ViewController.h"
#import "AlwaysRollView.h"

#define width [UIScreen mainScreen].bounds.size.width
static CGFloat const kScrollHeight = 250.f;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    
    NSArray *imageArr = @[@"5.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"1.jpg"];
    
    AlwaysRollView *alwaysRoll = [[AlwaysRollView alloc] initWithFrame:CGRectMake(0, 30, width, kScrollHeight)];
    alwaysRoll.imageArray = imageArr;
    alwaysRoll.isPageView = YES;
    [self.view addSubview:alwaysRoll];
}


@end
