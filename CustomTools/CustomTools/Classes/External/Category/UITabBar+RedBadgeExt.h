//
//  UITabBar+RedBadgeExt.h
//  DUGeneral
//
//  Created by 小毅 on 2018/7/10.
//  Copyright © 2018年 医和你信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (RedBadgeExt)
- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点

@end
