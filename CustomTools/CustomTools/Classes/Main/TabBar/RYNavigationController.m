//
//  RYNavigationController.m
//  CustomTools
//
//  Created by 小毅 on 2018/8/24.
//  Copyright © 2018年 小毅. All rights reserved.
//

#import "RYNavigationController.h"
#import "UIColor+RYExpand.h"
@interface RYNavigationController ()<UIGestureRecognizerDelegate>

@end



@implementation RYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    //设置NavigationBar
    [self setupNavigationBar];
}

//设置导航栏主题
- (void)setupNavigationBar
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
    [appearance setBarTintColor:[UIColor colorWithHexString:@"#0099FD" ]];
    
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttribute];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 22)];
        //        [backButton setImage:[UIImage imageNamed:@"ryNavigation_back_icon"] forState:UIControlStateNormal];
        ////        [backButton setImage:[UIImage imageNamed:@"ret-btn"] forState:UIControlStateHighlighted];
        //        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        //        [backButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        
        [backButton setImage:[UIImage imageNamed:@"ryNavigation_back_icon"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        //  再创建一个空白的UIBarButtonItem，通过设置他的宽度可以偏移其右侧的返回按钮的位置
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        spaceItem.width = -5;
        //  将两个UIBarButtonItem设置给当前的VC
        
        viewController.navigationItem.leftBarButtonItems = @[backItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popView
{
    [self popViewControllerAnimated:YES];
}

//手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
