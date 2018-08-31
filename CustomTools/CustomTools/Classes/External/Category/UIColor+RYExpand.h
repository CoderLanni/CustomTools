//
//  UIColor+RYExpand.h
//  FuTianApp
//
//  Created by 小毅 on 2018/1/17.
//  Copyright © 2018年 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RYExpand)

#pragma mark- 十六进制
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end
