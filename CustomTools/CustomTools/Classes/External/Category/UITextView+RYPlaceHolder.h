//
//  UITextView+RYPlaceHolder.h
//  DoctorWorkplaces
//
//  Created by 小毅 on 2018/2/26.
//  Copyright © 2018年 Exit_Cola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (RYPlaceHolder)
/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *ry_placeHolder;
/**
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *ry_placeHolderColor;
@end
