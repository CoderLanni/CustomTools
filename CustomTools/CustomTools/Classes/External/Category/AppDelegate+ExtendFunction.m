//
//  AppDelegate+ExtendFunction.m
//  DUGeneral
//
//  Created by 小毅 on 2018/6/4.
//  Copyright © 2018年 小毅. All rights reserved.
//

#import "AppDelegate+ExtendFunction.h"

#import "IQKeyboardManager.h"

//#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMAnalytics/MobClick.h>

//#import "WXApi.h"

#import "LoginViewController.h"

#import "JCHATConversationViewController.h"


#import "DGJPushApnMessageModel.h"
#import "DGWebViewController.h"  //H5网页
#import "JCHATConversationViewController.h" //客服消息
#import "MyOrderToSeeDoctorDetailBaseViewController.h"  //订单详情
#import "MyOrderRobOrderViewController.h"  //抢单中心
#import "TaskNotificationAreaViewController.h"       //消息提醒
#import "DGMineReportListViewController.h"          //历史健康报告
#import "MyOrderToRobOrderDetailViewController.h"               //抢单详细页
#import "DGVersionModel.h"
#import "DGMessageRemindURLModel.h"

//#import "DGMessageRemindModel.h"
//#import "DGMessageRemindURLModel.h"

//extern CFAbsoluteTime StartTime;


@implementation AppDelegate (ExtendFunction)

#pragma mark - 单例登录方法
LoginViewController * loginVC = nil;
+(void)sharedLoginHandleWithBlock:(ReturnLoginBlock)block{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //        loginVC = [[LoginViewController alloc] init];
    });
    //改变出现视图的透明度
    //    [Tools currentViewController].definesPresentationContext = YES; //self is presenting view controller
    //    loginVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    //    loginVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    //    if (_returnLoginBlock) {
    //        _returnLoginBlock();
    //    }
    //     __weak typeof(self) weakSelf = self;
    //    loginVC.returnLoginBlock = ^(id data) {
    //
    //        DLog(@"登录成功");
    //
    //        block(data);
    //    };
    //    block = loginVC.returnLoginBlock;
    
    //    [[Tools getCurrentViewController] presentViewController:loginVC animated:YES completion:^{
    //
    //    }];
    
}




#pragma mark- 版本跟新
//判断是否需要提示更新App
- (void)shareAppVersionAlertWithMessage:(NSString *)msg{
    if(![self judgeNeedVersionUpdate])  return ;
    //App内info.plist文件里面版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
    NSString *bundleId   = infoDict[@"CFBundleIdentifier"];
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleid=%@", bundleId];
    //两种请求appStore最新版本app信息 通过bundleId与appleId判断
    //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleid=%@", bundleId]
    //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appleid]
    NSURL *urlStr = [NSURL URLWithString:urlString];
    //创建请求体
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlStr];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            //            NSLog(@"connectionError->%@", connectionError.localizedDescription);
            return ;
        }
        NSError *error;
        NSDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            //            NSLog(@"error->%@", error.localizedDescription);
            return;
        }
        NSArray *sourceArray = resultsDict[@"results"];
        if (sourceArray.count >= 1) {
            //AppStore内最新App的版本号
            NSDictionary *sourceDict = sourceArray[0];
            NSString *newVersion = sourceDict[@"version"];
            if ([self judgeNewVersion:newVersion withOldVersion:appVersion])
            {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示:\n您的App不是最新版本，请问是否更新" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                    [alertVc dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertVc addAction:action1];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到AppStore，该App下载界面
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceDict[@"trackViewUrl"]]];
                }];
                [alertVc addAction:action2];
                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
            }
        }
    }];
}
//每天进行一次版本判断
- (BOOL)judgeNeedVersionUpdate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //获取年-月-日
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentDate"];
    if ([currentDate isEqualToString:dateString]) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"currentDate"];
    return YES;
}
//判断当前app版本和AppStore最新app版本大小
- (BOOL)judgeNewVersion:(NSString *)newVersion withOldVersion:(NSString *)oldVersion {
    NSArray *newArray = [newVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSArray *oldArray = [oldVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    for (NSInteger i = 0; i < newArray.count; i ++) {
        if ([newArray[i] integerValue] > [oldArray[i] integerValue]) {
            return YES;
        } else if ([newArray[i] integerValue] < [oldArray[i] integerValue]) {
            return NO;
        } else { }
    }
    return NO;
}

/**
 跳转App Store 更新软件
 
 @param title 提示Title
 @param msg 提示内容
 @param cacnelTitle 取消按钮title
 @param sureTitle 确定按钮Title
 */
+(void)alterToAppStoreUpDataAppWithTitle:(NSString *)title WithMSg:(NSString*)msg WithCacneTitle:(NSString *)cacnelTitle WithSureTitle:(NSString *)sureTitle{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:cacnelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //                    [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVc addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //        NSString *urlString = @"itms-apps://itunes.apple.com/cn/app/id1329918420?mt=8"; //更换id即可
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
        NSString *bundleId   = infoDict[@"CFBundleIdentifier"];
        NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleid=%@", bundleId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        //跳转到AppStore，该App下载界面
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceDict[@"trackViewUrl"]]];
    }];
    [alertVc addAction:action2];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
}


//#pragma mark - 微信
//-(void)setWeChat{
//    [WXApi registerApp:WeChat_AppKey];
//}
//#pragma mark -微信回调
//-(void)onResp:(BaseResp*)resp{
//
//    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//    NSString *strTitle;
//
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        strTitle = @"发送媒体消息结果";
//    }
//
//    if([resp isKindOfClass:[PayResp class]]){
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        strTitle = [NSString stringWithFormat:@"支付结果"];
//
//        switch (resp.errCode) {
//            case WXSuccess:{
//                strMsg = @"恭喜您，支付成功!";
//
//                [[NSNotificationCenter defaultCenter]  postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"success"}];
//
//                break;
//            }
//            case WXErrCodeUserCancel:{
//                strMsg = @"已取消支付!";
//                [[NSNotificationCenter defaultCenter]  postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
//                break;
//            }
//            default:{
//
//                strMsg = [NSString stringWithFormat:@"支付失败 !"];
//                [[NSNotificationCenter defaultCenter]  postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"fail"}];
//                break;
//            }
//        }
//
//      
//    }
//
//}





#pragma mark- 键盘
-(void)setKeyboardHandle{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
    
}



#pragma mark- 友盟
-(void)setUMConfigureHandle{
    //    [UMConfigure initWithAppkey:@"5b14a520f29d985422000039" channel:@"App Store"];
    
    //开发者需要显式的调用此函数，日志系统才能工作
    //    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengAppkey];
    [UMConfigure initWithAppkey:UMengAppkey channel:@"App Store"];
    //    [UMConfigure initWithAppkey:@"5b14a520f29d985422000039" channel:@"App Store"];
    
    [MobClick setScenarioType:E_UM_GAME|E_UM_DPLUS];
    //    [MobClick setLogEnabled];
    // Push's basic setting
    
    // Share's setting
    [self setupUSharePlatforms];   // required: setting platforms on demand
    [self setupUShareSettings];
    
    
    
    
    //    double launchTime = (CFAbsoluteTimeGetCurrent() - StartTime);
    //    NSLog(@"double======%f",launchTime);
}


- (void)setupUSharePlatforms
{
    //    /*
    //     设置微信的appKey和appSecret
    //     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
    //     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChat_AppKey appSecret:WeChat_Secret redirectURL:@"http://mobile.umeng.com/social"];//    /*
    //     * 移除相应平台的分享，如微信收藏
    //     */
    //    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    //
    //    /* 设置分享到QQ互联的appID
    //     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    //     100424468.no permission of union id
    //     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
    //     */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    //
    //    /*
    //     设置新浪的appKey和appSecret
    //     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
    //     */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    //
    //    /* 钉钉的appKey */
    //    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
    //
    //    /* 支付宝的appKey */
    //    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:nil];
    //
    //    /* 设置易信的appKey */
    //    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //
    //    /* 设置领英的appKey和appSecret */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
    //
    //    /* 设置Twitter的appKey和appSecret */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
    //
    //    /* 设置Facebook的appKey和UrlString */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:nil];
    //
    //    /* 设置Pinterest的appKey */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
    //
    //    /* dropbox的appKey */
    //    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
    //
    //    /* vk的appkey */
    //    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];
    
}

- (void)setupUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

#pragma mark- 极光

-(void)setJPushAndJMessageHandleWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions{
    
    //初始化APNs代码
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    //    初始化JPush代码
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JMESSAGE_APPKEY
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    
#pragma mark- Jmessage
    
    
    // Required - 启动 JMessage SDK
    [JMessage setupJMessage:launchOptions appKey:JMESSAGE_APPKEY channel:nil apsForProduction:NO category:nil messageRoaming:YES];
    // Required - 注册 APNs 通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JMessage registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    } else {
        //categories 必须为nil
        [JMessage registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                      UIRemoteNotificationTypeSound |
                                                      UIRemoteNotificationTypeAlert)
                                          categories:nil];
    }
    
    
    
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册token
    [JMessage registerDeviceToken:deviceToken];
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - JPUSHRegisterDelegate
// MARK:  在前台收到通知就走这个方法
// iOS 10 Support(收到推送就进行的处理)
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        DGJPushApnMessageModel *userInfoModel =[DGJPushApnMessageModel yy_modelWithDictionary:userInfo ];
        DGJPushApnMessageModel *apsModel =[DGJPushApnMessageModel yy_modelWithDictionary:userInfoModel.aps ];
        /*
         //        if ([userInfoModel.url isEqualToString:@"homePage"]) {//跳到首页
         //            [Tools currentViewController].tabBarController.selectedIndex = 0;
         //            [[Tools currentViewController].navigationController popToRootViewControllerAnimated:YES];
         //
         //
         //        }
         //        else if ([userInfoModel.url isEqualToString:@"visitDetails"]) {//随访记录
         //            DGMineReportFollowUpViewController *followVC = [DGMineReportFollowUpViewController new];
         //            [[Tools currentViewController].navigationController pushViewController:followVC animated:YES];
         //        }
         //        else if ([userInfoModel.url isEqualToString:@"healthReport"]) {//健康报告
         //            DGMineReportHealthReportViewController *reportVC   =[DGMineReportHealthReportViewController new];
         //            reportVC.type = 0;
         //            [[Tools currentViewController].navigationController pushViewController:reportVC animated:YES];
         //        }
         //        else if ([userInfoModel.url isEqualToString:@"appointmentDetails"]) {//预约详情
         //
         //            DGAppointmentRecordDetailViewController *recordC = [DGAppointmentRecordDetailViewController new];
         //            [[Tools currentViewController].navigationController pushViewController:recordC animated:YES];
         //
         //        }
         //        else if ([userInfoModel.url isEqualToString:@"mine"]) {//我的tab(审核通知)
         //            [[Tools currentViewController].navigationController popToRootViewControllerAnimated:YES];
         //        }
         //        else if ([userInfoModel.url isEqualToString:@"service"]) {//客服消息
         //            [self JMessageHadleWithViewController:[Tools currentViewController]];
         //        }
         //        else if ([userInfoModel.url isEqualToString:@"messageList"]) {//消息列表
         
         //        DGMessageRemindViewController *messageVC = [DGMessageRemindViewController new];
         //        [[Tools currentViewController].navigationController pushViewController:messageVC animated:YES];
         //
         //        }
         //        else if ([userInfoModel.url isEqualToString:@"webView"]) {//H5网页
         //            DGWebViewController *webVC = [DGWebViewController new];
         //            //            webVC.titleStr = @"百度";
         //            webVC.urlStr = userInfoModel.urlData;
         //            [[Tools currentViewController].navigationController pushViewController:webVC animated:YES];
         //        }
         //
         
         */
        
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// MARK:   点击通知走这个方法(iOS10以上)
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        DGJPushApnMessageModel *userInfoModel =[DGJPushApnMessageModel yy_modelWithDictionary:userInfo ];
        DGJPushApnMessageModel *apsModel =[DGJPushApnMessageModel yy_modelWithDictionary:userInfoModel.aps ];
        
        if(userInfoModel.url){
            NSMutableString* urlParamStr=[[NSMutableString alloc]initWithString:userInfoModel.urlData];
            //        NSString *urlParamStr = [ ];
            [urlParamStr insertString:@"?" atIndex:0];
            NSDictionary *dict =  [Tools dictionaryWithUrlString:urlParamStr];
            DGMessageRemindURLModel *urlModel = [DGMessageRemindURLModel yy_modelWithDictionary:dict];
            DLog(@"消息model == %@",urlModel.visitNumber);
            
            if ([userInfoModel.url isEqualToString:JPush_URL_homePage]) {//跳到首页
                [Tools currentViewController].tabBarController.selectedIndex = 0;
                [[Tools currentViewController].navigationController popToRootViewControllerAnimated:YES];
                
                
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_mine]) {//我的tab
                [Tools currentViewController].tabBarController.selectedIndex = 3;
                [[Tools currentViewController].navigationController popToRootViewControllerAnimated:YES];
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_service]) {//客服消息
                //                [self JMessageHadleWithViewController:[Tools currentViewController]];
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_orderDetail]) {//订单详情
                
                MyOrderToSeeDoctorDetailBaseViewController *messageVC = [MyOrderToSeeDoctorDetailBaseViewController new];
                [[Tools currentViewController].navigationController pushViewController:messageVC animated:YES];
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_orderRemind]) {//抢单中心
                
                //            MyOrderRobOrderViewController *robOrderVC = [MyOrderRobOrderViewController new];
                //            [[Tools currentViewController].navigationController pushViewController:robOrderVC animated:YES];
                
                [self getToJudgeOrderStatueNetworkingWithVisitNumber:urlModel.visitNumber];
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_messageList]) {//消息列表
                
                TaskNotificationAreaViewController *messageVC = [TaskNotificationAreaViewController new];
                [[Tools currentViewController].navigationController pushViewController:messageVC animated:YES];
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_webView]) {//H5网页
                DGWebViewController *webVC = [DGWebViewController new];
                //            webVC.titleStr = @"百度";
                webVC.urlStr = userInfoModel.urlData;
                [[Tools currentViewController].navigationController pushViewController:webVC animated:YES];
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_followOrderFixRemind]) {//跟诊单修改
                MyOrderServicesheetViewController *fixVC = [MyOrderServicesheetViewController new];
                fixVC.visitNumber = urlModel.visitNumber;
                fixVC.type = 4;
                [[Tools currentViewController].navigationController pushViewController:fixVC animated:YES];
            }
            else if ([userInfoModel.url isEqualToString:JPush_URL_healthReportList]) {//历史健康报告（列表）
                DGMineReportListViewController *reportVC = [DGMineReportListViewController new];
                reportVC.patientId = urlModel.visitNumber;
                [[Tools currentViewController].navigationController pushViewController:reportVC animated:YES];
            }
            else{
                [AppDelegate alterToAppStoreUpDataAppWithTitle:@"当前版本无法查看该消息，请升级。" WithMSg:nil WithCacneTitle:@"取消" WithSureTitle:@"去更新"];
            }
            [self getMessageNotReadNetworking]; //角标
        }
        
        
    }
    completionHandler();  // 系统要求执行这个方法
}

// MARK:  点击通知走这个方法(iOS 7 Support以上)
//iOS 7 Support以上
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    //    [JPUSHService handleRemoteNotification:userInfo];
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    DGJPushApnMessageModel *userInfoModel =[DGJPushApnMessageModel yy_modelWithDictionary:userInfo ];
    DGJPushApnMessageModel *apsModel =[DGJPushApnMessageModel yy_modelWithDictionary:userInfoModel.aps ];
    
    if(userInfoModel.url){
        
        NSMutableString* urlParamStr=[[NSMutableString alloc]initWithString:userInfoModel.urlData];
        //        NSString *urlParamStr = [ ];
        [urlParamStr insertString:@"?" atIndex:0];
        NSDictionary *dict =  [Tools dictionaryWithUrlString:urlParamStr];
        DGMessageRemindURLModel *urlModel = [DGMessageRemindURLModel yy_modelWithDictionary:dict];
        DLog(@"消息model == %@",urlModel.visitNumber);
        //
        if ([userInfoModel.url isEqualToString:JPush_URL_homePage]) {//跳到首页
            [Tools currentViewController].tabBarController.selectedIndex = 0;
            [[Tools currentViewController].navigationController popToRootViewControllerAnimated:YES];
            
            
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_mine]) {//我的tab
            [Tools currentViewController].tabBarController.selectedIndex = 3;
            [[Tools currentViewController].navigationController popToRootViewControllerAnimated:YES];
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_service]) {//客服消息
            //                [self JMessageHadleWithViewController:[Tools currentViewController]];
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_orderDetail]) {//订单详情
            
            MyOrderToSeeDoctorDetailBaseViewController *messageVC = [MyOrderToSeeDoctorDetailBaseViewController new];
            [[Tools currentViewController].navigationController pushViewController:messageVC animated:YES];
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_orderRemind]) {//抢单中心
            
            //        MyOrderRobOrderViewController *robOrderVC = [MyOrderRobOrderViewController new];
            //        [[Tools currentViewController].navigationController pushViewController:robOrderVC animated:YES];
            
            [self getToJudgeOrderStatueNetworkingWithVisitNumber:urlModel.visitNumber];
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_messageList]) {//消息列表
            
            TaskNotificationAreaViewController *messageVC = [TaskNotificationAreaViewController new];
            [[Tools currentViewController].navigationController pushViewController:messageVC animated:YES];
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_webView]) {//H5网页
            DGWebViewController *webVC = [DGWebViewController new];
            //            webVC.titleStr = @"百度";
            webVC.urlStr = userInfoModel.urlData;
            [[Tools currentViewController].navigationController pushViewController:webVC animated:YES];
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_followOrderFixRemind]) {//跟诊单修改
            MyOrderServicesheetViewController *fixVC = [MyOrderServicesheetViewController new];
            fixVC.visitNumber = urlModel.visitNumber;
            fixVC.type = 4;
            [[Tools currentViewController].navigationController pushViewController:fixVC animated:YES];
        }
        else if ([userInfoModel.url isEqualToString:JPush_URL_healthReportList]) {//历史健康报告（列表）
            DGMineReportListViewController *reportVC = [DGMineReportListViewController new];
            reportVC.patientId = urlModel.visitNumber;
            [[Tools currentViewController].navigationController pushViewController:reportVC animated:YES];
        }
        else{
            [AppDelegate alterToAppStoreUpDataAppWithTitle:@"当前版本无法查看该消息，请升级。" WithMSg:nil WithCacneTitle:@"取消" WithSureTitle:@"去更新"];
        }
        [self getMessageNotReadNetworking]; //角标
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


// 通知事件监听(被踢下线)
- (void)onReceiveNotificationEvent:(JMSGNotificationEvent *)event{
    switch (event.eventType) {
        case kJMSGEventNotificationCurrentUserInfoChange:
            NSLog(@"Current user info change Event ");
            break;
        case kJMSGEventNotificationReceiveFriendInvitation:
            NSLog(@"Receive Friend Invitation Event ");
            break;
        case kJMSGEventNotificationAcceptedFriendInvitation:
            NSLog(@"Accepted Friend Invitation Event ");
            break;
        case kJMSGEventNotificationDeclinedFriendInvitation:
            NSLog(@"Declined Friend Invitation Event ");
            break;
        case kJMSGEventNotificationDeletedFriend:
            NSLog(@"Deleted Friend Event ");
            break;
        case kJMSGEventNotificationReceiveServerFriendUpdate:
            NSLog(@"Receive Server Friend Update Event ");
            break;
        case kJMSGEventNotificationLoginKicked:
            NSLog(@"Login Kicked Event ");
            break;
        case kJMSGEventNotificationServerAlterPassword:
            NSLog(@"Server Alter Password Event ");
            break;
        case kJMSGEventNotificationUserLoginStatusUnexpected:
            NSLog(@"User login status unexpected Event ");
            break;
        default:
            NSLog(@"Other Notification Event ");
            break;
    }
}

#pragma mark - IM

-(void)JMessageHadleWithViewController:(UIViewController *)viewController{
    
    //    self.app = [UIApplication sharedApplication];
    //    //开启－忽略用户的操作事件
    //    [self.app beginIgnoringInteractionEvents];
    
    
    
    [self JMessageRegisterUserAndRegisterGroupHandleWithViewController:viewController];
    
}


-(void)JMessageRegisterUserAndRegisterGroupHandleWithViewController:(UIViewController *)viewController{
    JMSGUserInfo *info = [[JMSGUserInfo alloc]init];
    info.nickname = GVUserDe.userName;
    
    [JMSGUser registerWithUsername:GVUserDe.userIdMD5 password:GVUserDe.userIdMD5 userInfo:info completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            //注册成功
            DLog(@"注册成功");
            [JMSGGroup myGroupArray:^(id resultObject, NSError *error) {
                NSArray *gidArr = (NSArray *)resultObject;
                if (gidArr.count == 0) {//没有群了
                    //根据用户,名字去创建群组
                    [JMSGGroup createGroupWithName:GVUserDe.userId desc:[NSString stringWithFormat:@"%@的IM群",GVUserDe.phone] memberArray:[NSArray arrayWithObjects:GVUserDe.userIdMD5, nil] completionHandler:^(id resultObject, NSError *error) {
                        JMSGGroup * groud =  (JMSGGroup *)resultObject;
                        [self JMessageLoginAndCreateConversationHandleWithGroupID:groud.gid withViewController:viewController];
                    }];
                }
                else{
                    [self JMessageLoginAndCreateConversationHandleWithGroupID:gidArr[0] withViewController:viewController];
                }
                
            }];
            
        } else {
            //注册失败
            DLog(@"注册失败");
            //            //根据用户,名字去创建群组
            //            [JMSGGroup createGroupWithName:@"15976619512" desc:@"ziji " memberArray:[NSArray arrayWithObjects:@"15976619512", nil] completionHandler:^(id resultObject, NSError *error) {
            //                JMSGGroup * groud =  (JMSGGroup *)resultObject;
            ////                [self JMessageLoginAndCreateConversationHandleWithGroup:groud withViewController:nil];
            //            }];
            [JMSGGroup myGroupArray:^(id resultObject, NSError *error) {
                NSArray *gidArr = (NSArray *)resultObject;
                if (gidArr.count == 0) {//没有群了
                    //根据用户,名字去创建群组
                    [JMSGGroup createGroupWithName:GVUserDe.userId desc:[NSString stringWithFormat:@"%@的IM群",GVUserDe.phone] memberArray:[NSArray arrayWithObjects:GVUserDe.userIdMD5, nil] completionHandler:^(id resultObject, NSError *error) {
                        JMSGGroup * groud =  (JMSGGroup *)resultObject;
                        [self JMessageLoginAndCreateConversationHandleWithGroupID:groud.gid withViewController:nil];
                    }];
                }
                else{
                    [self JMessageLoginAndCreateConversationHandleWithGroupID:gidArr[0] withViewController:nil];
                }
                
            }];
            
        }
        
        
        
    }];
    
}



//先注册用户,然后登录用户
-(void)JMessageLoginAndCreateConversationHandleWithGroupID:(NSString*)groupid withViewController:(UIViewController *)viewController{
    DLog(@"客服 == %@",GVUserDe.userIdMD5);
    [JMSGUser loginWithUsername:GVUserDe.userIdMD5 password:GVUserDe.userIdMD5 completionHandler:^(id resultObject, NSError *error) {
        //        [self.hub show:NO];
        //关闭－忽略用户的操作事件
        //        [self.app endIgnoringInteractionEvents];
        if (!error) {
            //登录成功
            DLog(@"登录成功");
            //根据群ID创建群回话
            if ([JMSGConversation groupConversationWithGroupId:groupid]) {
                JCHATConversationViewController *sendMessageCtl =[[JCHATConversationViewController alloc] init];
                sendMessageCtl.tabBarController.hidesBottomBarWhenPushed = YES;
                sendMessageCtl.superViewController = self;
                JMSGConversation *conversation = [JMSGConversation groupConversationWithGroupId:groupid];
                sendMessageCtl.conversation = conversation;
                //关闭－忽略用户的操作事件
                //                [self.app endIgnoringInteractionEvents];
                [[Tools currentViewController].navigationController.childViewControllers[0].navigationController pushViewController:sendMessageCtl animated:YES];
            }
            else{
                [JMSGConversation createGroupConversationWithGroupId:groupid completionHandler:^(id resultObject, NSError *error) {
                    if (!error) {
                        JCHATConversationViewController *sendMessageCtl =[[JCHATConversationViewController alloc] init];
                        sendMessageCtl.tabBarController.hidesBottomBarWhenPushed = YES;
                        sendMessageCtl.superViewController = self;
                        JMSGConversation *conversation = [JMSGConversation groupConversationWithGroupId:groupid];
                        sendMessageCtl.conversation = conversation;
                        //关闭－忽略用户的操作事件
                        //                        [self.app endIgnoringInteractionEvents];
                        [[Tools currentViewController].navigationController.childViewControllers[0].navigationController pushViewController:sendMessageCtl animated:YES];
                        DLog(@"=========>>>>>>>>>>>>>      %@",[Tools currentNavigationController]);
                        DLog(@"=========>>>>>>>>>>>>>      %@",viewController.navigationController);
                        DLog(@"=========>>>>>>>>>>>>>      %@",viewController.navigationController);
                        
                    }
                }];
                
                
            }
            //
            
        } else {
            //登录失败
            DLog(@"IM登录失败");
            //            [self.hub show:NO];
            //关闭－忽略用户的操作事件
            [self.app endIgnoringInteractionEvents];
            return ;
        }
    }];
    
}



#pragma mark- 回调


// 仅支持iOS9以上系统

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    
    if (!result) {
        //
        //        // 其他如支付等SDK的回调
        //
        //        if ([url.host isEqualToString:@"safepay"]) {
        //
        //            //跳转支付宝钱包进行支付，处理支付结果
        //
        //            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        //
        //                NSLog(@"result = %@",resultDic);
        //
        //            }];
        //
        //        }
        
        //        if ([url.scheme isEqualToString:WeChat_AppKey])
        //
        //        {
        //
        //            return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        //
        //        }
        
    }
    
    return result;
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url

{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    if (!result) {
        
        //        // 其他如支付等SDK的回调
        //
        //        if ([url.host isEqualToString:@"safepay"]) {
        //
        //            //跳转支付宝钱包进行支付，处理支付结果
        //
        //            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        //
        //                NSLog(@"result = %@",resultDic);
        //
        //            }];
        //
        //        }
        
        //        if ([url.scheme isEqualToString:WeChat_AppKey])
        //
        //        {
        //
        //            return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
        //
        //        }
        
    }
    
    return result;
    
}



- (BOOL)application:(UIApplication *)application

            openURL:(NSURL *)url

  sourceApplication:(NSString *)sourceApplication

         annotation:(id)annotation {
    
    
    //
    //    if ([url.host isEqualToString:@"safepay"]) {
    //
    //        //跳转支付宝钱包进行支付，处理支付结果
    //
    //        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    //
    //            NSLog(@"result = %@",resultDic);
    //
    //        }];
    //
    //    }
    //
    //    if ([url.scheme isEqualToString:WeChat_AppKey])
    //
    //    {
    //
    //        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    //
    //    }
    
    
    
    return YES;
    
}





#pragma mark - networking
/**
 消息未读数量
 */
-(void)getMessageNotReadNetworking{
    
    //    NSString *urlStr = [NSString stringWithFormat:@"%@?userId=%@",general_messageCenters_count_unread,GVUserDe.userId];
    //    [NetworkingHTTPClient sendGetWithURL:urlStr parameter:nil success:^(id JSON, NSInteger resultCode) {
    //
    //        if (resultCode == 0) {
    //               dispatch_async(dispatch_get_main_queue(), ^{
    //            //            [JPUSHService resetBadge];
    //            //            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //
    //            DGMessageRemindModel *model = [DGMessageRemindModel yy_modelWithDictionary:JSON];
    //
    //            if (model.count == 0) {
    //                [JPUSHService resetBadge];//清楚极光服务器角标
    //                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//appIcon角标
    ////                UITabBarItem * item=[[Tools currentViewController].tabBarController.tabBar.items objectAtIndex:3];
    ////                // 去掉角标
    ////                item.badgeValue = nil;
    //                 [[Tools currentViewController].tabBarController.tabBar hideBadgeOnItemIndex:3];
    //            }
    //            else{
    ////                UITabBarItem * item=[[Tools currentViewController].tabBarController.tabBar.items objectAtIndex:3];
    ////                // 显示
    ////                item.badgeValue=[NSString stringWithFormat:@""];
    //                 [[Tools currentViewController].tabBarController.tabBar showBadgeOnItemIndex:3];
    //                // 去掉角标
    //                //                item.badgeValue = nil;
    //                //                // 设置应用程序的角标
    //                //                [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    //                //                // 取消
    //                //                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //            }
    //
    //
    //            });
    //        }
    
    //    } failure:^(NSError *error) {
    //
    //    }];
    
}



/**
 根据appCode获取最新的版本信息
 */
-(void)getClientVersionNetworking{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",sys_client_versions_lasts];
    [NetworkingHTTPClient sendGetWithURL:urlStr parameter:nil success:^(id JSON, NSInteger resultCode) {
        
        if (resultCode == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                DGVersionModel *model = [DGVersionModel yy_modelWithDictionary:JSON];
                DLog(@"版本号========>%@",kAppVersion);
                if (![model.versionText isEqualToString:kAppVersion]) {
                    [self shareAppVersionAlertWithMessage:model.upgradeIntro];
                }
            });
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}



/**
 * 判断是否给抢了
 */
- (void)getToJudgeOrderStatueNetworkingWithVisitNumber:(NSString *)visitNumber{
    
    NSString *detailUrl = [NSString stringWithFormat:@"%@/waitOccupyOrContact/visitNumber?visitNumber=%@&assistOrderStatus=0",assistantUrl_myOrder,visitNumber];
    [[Tools currentViewController].view makeToastActivity:CSToastPositionCenter];//菊花出现
    
    [NetworkingHTTPClient sendGetWithURL:detailUrl parameter:nil success:^(id JSON, NSInteger resultCode) {
        [[Tools currentViewController].view hideToastActivity];//菊花消失
        if (resultCode == 0) {
            DLog(@"订单还没抢");
            // TODO: 跳转抢单页面
            MyOrderToRobOrderDetailViewController *vc = [[MyOrderToRobOrderDetailViewController alloc] init];
            
            vc.visitNumber = visitNumber;
            
            [[Tools currentViewController].navigationController pushViewController:vc animated:YES];
        }
        else if (resultCode == 6011) { //抢单已被抢！请再接再厉
            DLog(@"订单已经给抢了");
            MyOrderRobOrderViewController *robOrderVC = [MyOrderRobOrderViewController new];
            [[Tools currentViewController].navigationController pushViewController:robOrderVC animated:YES];
        }
        else {
            //            [[Tools currentViewController].view hideToastActivity];//菊花消失
        }
    } failure:^(NSError *error) {
        [[Tools currentViewController].view hideToastActivity];//菊花消失
        [XPToast showWithText:@"网络请求失败"];
    }];
}



@end
