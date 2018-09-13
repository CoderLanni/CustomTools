//
//  ProjectCustomDefine.h
//  CustomTools
//
//  Created by 小毅 on 2018/8/24.
//  Copyright © 2018年 小毅. All rights reserved.
//

#ifndef ProjectCustomDefine_h
#define ProjectCustomDefine_h


#pragma mark-  代码缩写

#pragma mark 获取系统对象
#define kApplication                        [UIApplication sharedApplication]
#define kAppWindow                          [UIApplication sharedApplication].delegate.window
#define kAppDelegate                        [AppDelegate shareAppDelegate]
#define kRootViewController                 [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults                       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter                 [NSNotificationCenter defaultCenter]
#define kBundle                             [NSBundle mainBundle]
#define kMainScreen                         [UIScreen mainScreen]

#pragma mark- 高度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//头高度,iPhone X：88，iPhone 8：64
#define Nav_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)
#define Nav_StatusBar_H [[UIApplication sharedApplication] statusBarFrame].size.height
// 适配iPhone x 底栏高度  (iphoneX高了34)
#define Tabbar_HEIGHT  ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//适应屏幕的高度
#define RYAdaptScreenSizeH(ui_w,ui_h) ((ui_h)/(ui_w)*[UIScreen mainScreen].bounds.size.width)
//适应屏幕的宽
#define RYAdaptScreenSizeW(ui_w,ui_h) ((ui_h)/(ui_w)*[UIScreen mainScreen].bounds.size.height)
///适应屏幕的宽
#define RYRealAdaptWidthValue(ui_w) ((ui_w)/375.0f*[UIScreen mainScreen].bounds.size.width)    //6S:375pt    6P:414.0f


#pragma mark- GVUserDefaults
#define GVUserDe                            [GVUserDefaults standardUserDefaults]


#pragma mark- NSString
#define ChangeNullString(obj)                [[NSString stringWithFormat:@"%@",obj] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",obj] isEqualToString:@"(null)"]?@"":[NSString stringWithFormat:@"%@",obj]
#define IntValueToString(obj)                  [NSString stringWithFormat:@"%ld",obj]
#define FloatValueToString(obj)                  [NSString stringWithFormat:@"%.2f",obj]

#pragma mark 强弱引用
#define weakSelf(type)            __weak typeof(type)weak##type = type;
#define kStrongSelf(type)         __strong typeof(type)type = weak##type;



#endif /* ProjectCustomDefine_h */
