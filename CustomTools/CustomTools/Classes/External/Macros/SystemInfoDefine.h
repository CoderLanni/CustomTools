//
//  SystemInfoDefine.h
//  CustomTools
//
//  Created by 小毅 on 2018/8/24.
//  Copyright © 2018年 小毅. All rights reserved.
//

#ifndef SystemInfoDefine_h
#define SystemInfoDefine_h


#pragma mark - 时间
//获取系统时间戳
#define getCurentTime           [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

#pragma mark - 系统信息
#pragma mark 获取当前语言
#define RYCurrentLanguage           ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark 判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE                        (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD                          (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
////判断是否为ipod
//#define IS_IPOD                         ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
//// 判断是否为 iPhone 5SE
//#define iPhone5SE                        [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
//// 判断是否为iPhone 6/6s
//#define iPhone6_6s                       [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
//// 判断是否为iPhone 6Plus/6sPlus
//#define iPhone6Plus_6sPlus               [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
#define IS_iPHONE_X (SCREEN_HEIGHT == 812.f ? YES : NO)          //判断是否iPhone X
//获取系统版本
#define IOS_SYSTEM_VERSION               [[[UIDevice currentDevice] systemVersion] floatValue]
//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER          (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
//APP版本号
#define kAppVersion                     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//设备版本号
#define kSystemVersion                   [[UIDevice currentDevice] systemVersion]
//设备标识符
#define DeviceIdentifier                [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define DeviceName                      [[UIDevice currentDevice] name];  //获取设备名称 例如：RY的手机
#define DeviceSystemName                [[UIDevice currentDevice] systemName]; //获取系统名称 例如：iPhone OS
#define DeviceModel                [[UIDevice currentDevice] model]; //获取设备的型号 例如：iPhone
/***************************系统版本*****************************/


//获取手机系统的版本
#define HitoSystemVersion               [[[UIDevice currentDevice] systemVersion] floatValue]
////是否为iOS7及以上系统
//#define HitoiOS7                        ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
////是否为iOS8及以上系统
//#define HitoiOS8                        ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
////是否为iOS9及以上系统
//#define HitoiOS9                        ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
////是否为iOS10及以上系统
//#define HitoiOS10                       ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
////是否为iOS11及以上系统
//#define HitoiOS11                       ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)






#pragma mark - 模式
#pragma mark  开发or上线功能
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#pragma mark 真机or模拟器
//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif


#endif /* SystemInfoDefine_h */
