//
//  MainTabBarViewController.m
//  CustomTools
//
//  Created by 小毅 on 2018/8/24.
//  Copyright © 2018年 小毅. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "RYNavigationController.h"

#import "RYHomeViewController.h"
#import "RYDiscoverViewController.h"
#import "RYMineViewController.h"



@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildViewController];
    //    self.tabBarController.tabBar.delegate = self;
}

#pragma mark tabbar视图控制
-(void)setUpAllChildViewController{
    
    //TabBar_OrganizationChart_Selected
    RYHomeViewController  *homeVC = [[RYHomeViewController alloc]init];
    UIImage *homeVCA = [UIImage imageNamed:@"tab_icon_order_nor"];
    UIImage *homeVCB = [UIImage imageNamed:@"tab_icon_order_sel"];
    [self setUpOneChildViewController:homeVC imageBefore:homeVCA imageAfter:homeVCB title:@"首页" withTag:100];
    
    
    RYDiscoverViewController *discorerVC = [[RYDiscoverViewController alloc]init];
    UIImage *discorerVCA = [UIImage imageNamed:@"tab_icon_work_nor"];
    UIImage *discorerVCB = [UIImage imageNamed:@"tab_icon_work_sel"];
    [self setUpOneChildViewController:discorerVC imageBefore:discorerVCA imageAfter:discorerVCB title:@"发现" withTag:101];
    
    //    NoticeVTMagicViewController *noticeVC = [[NoticeVTMagicViewController alloc]init];
    RYMineViewController *mineVC = [[RYMineViewController alloc] init];
//    mineVC.navigationItem.title = @"客服";
    UIImage *mineVCA = [UIImage imageNamed:@"tab_icon_msg_nor"];
    UIImage *mineVCB = [UIImage imageNamed:@"tab_icon_msg_sel"];
    [self setUpOneChildViewController:mineVC imageBefore:mineVCA imageAfter:mineVCB title:@"我的" withTag:102];
    

    
    
    [self modifiedTabBarBackgroundColor];
    
}

/**
 修改tabbar的背景颜色
 */
-(void)modifiedTabBarBackgroundColor{
    
    //修改tabbar的背景颜色
    NSLog(@"%i,%i",(int)self.tabBar.frame.size.height,(int)self.tabBar.frame.size.width);
    
    CGSize size;
    size.width = self.tabBar.frame.size.width;
    size.height = self.tabBar.frame.size.height;
    //    UIImage *image = [UIImage imageNamed:@"BGWhiteColor"];
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] andSize:size];
    self.tabBar.backgroundImage =  [self scaleToSize:image size:size];
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


#pragma mark tabbar item方法
- (void)setUpOneChildViewController:(UIViewController *)viewController imageBefore:(UIImage *)imageBefore imageAfter:(UIImage *)imageAfter title:(NSString *)title withTag:(NSInteger)tag{
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //    [UIImage imageNamed:@"bodybg"]
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];//Nav颜色
    
    
    CGSize size;
    size.width = 2000;
    size.height = 100;
    //    UIImage *image = [UIImage imageNamed:@"navigation_bg"];
    ////     UIImage *image = [UIImage imageWithColor:[UIColor greenColor] andSize:size];
    //    [[UINavigationBar appearance] setBackgroundImage:[self scaleToSize:image size:size] forBarMetrics:UIBarMetricsDefault];//导航加背景图片
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];//按钮颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#FFFFFF"]}];//title颜色
    RYNavigationController *navC = [[RYNavigationController alloc]initWithRootViewController:viewController];
    imageBefore = [imageBefore imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageAfter = [imageAfter imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:imageBefore selectedImage:imageAfter];
    [navC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4693EA"]} forState:UIControlStateSelected];//bar字体颜色(选中)
    [navC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#B3B3B3"]} forState:UIControlStateNormal];//bar字体颜色(未选中)
    navC.tabBarItem.tag = tag;
    [self addChildViewController:navC];
    
    
    
}



@end
