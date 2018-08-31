//
//  UIView+RYFrame.h
//  DoctorWorkplaces
//
//  Created by 刘荣毅 on 2018/1/2.
//  Copyright © 2018年 Exit_Cola. All rights reserved.
//
//Class: 改变控件的位置大小
#import <UIKit/UIKit.h>

@interface UIView (RYFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@end
