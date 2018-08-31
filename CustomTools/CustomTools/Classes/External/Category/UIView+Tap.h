//
//  UIView+Tap.h
//  SuWangMall_App
//
//  Created by 刘荣毅 on 2017/10/18.
//  Copyright © 2017年 Lanni. All rights reserved.
//

//Class: 为UIView 添加点击事件方法
    /****************** 为UIView 添加点击事件方法  ******************/

#import <UIKit/UIKit.h>

@interface UIView (Tap)
- (void)addTapBlock:(void(^)(id obj))tapAction;
@end




/*!   *******用法:********
 
 [self.systemInfoV addTapBlock:^(id obj) {
 DLog(@"点击系统消息");
 }];
 
 */
