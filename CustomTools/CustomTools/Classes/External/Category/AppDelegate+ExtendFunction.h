//
//  AppDelegate+ExtendFunction.h
//  DUGeneral
//
//  Created by 小毅 on 2018/6/4.
//  Copyright © 2018年 小毅. All rights reserved.
//


static NSString *channel = @"Main channel";
static BOOL isProduction = FALSE;
typedef void(^ReturnLoginBlock)(id data);
#import "AppDelegate.h"

@interface AppDelegate (ExtendFunction) 

//@property(nonatomic ,copy)void (^returnLoginBlock)(void);
@property(nonatomic,copy)ReturnLoginBlock returnLoginBlock;

@property(nonatomic ,strong) UIApplication *app;

#pragma mark - 单例登录方法
+(void)sharedLoginHandleWithBlock:(ReturnLoginBlock)block;

#pragma mark- 版本跟新
//判断是否需要提示更新App
- (void)shareAppVersionAlert;
/**
 跳转App Store 更新软件
 
 @param title 提示Title
 @param msg 提示内容
 @param cacnelTitle 取消按钮title
 @param sureTitle 确定按钮Title
 */
+(void)alterToAppStoreUpDataAppWithTitle:(NSString *)title WithMSg:(NSString*)msg WithCacneTitle:(NSString *)cacnelTitle WithSureTitle:(NSString *)sureTitle;

#pragma mark- 键盘
-(void)setKeyboardHandle;


#pragma mark- 微信
//-(void)setWeChat;

#pragma mark- 友盟
-(void)setUMConfigureHandle;


#pragma mark- 极光
-(void)setJPushAndJMessageHandleWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;


-(void)getMessageNotReadNetworking;
/**
 根据appCode获取最新的版本信息
 */
-(void)getClientVersionNetworking;



@end
