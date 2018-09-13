//
//  RYWebProgressLayer.h
//  DUGeneral
//
//  Created by 小毅 on 2018/8/24.
//  Copyright © 2018年 医和你信息科技有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface RYWebProgressLayer : CAShapeLayer


+ (instancetype)layerWithFrame:(CGRect)frame;

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;


@end
