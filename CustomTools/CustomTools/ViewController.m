//
//  ViewController.m
//  CustomTools
//
//  Created by 小毅 on 2018/8/21.
//  Copyright © 2018年 小毅. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

#import <UIView+Toast.h>
#import "ToastShowView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor yellowColor];
    btn.frame = CGRectMake(10, 100, 100, 50);
    [btn addTarget:self action:@selector(ff) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn11 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn11.backgroundColor = [UIColor yellowColor];
    btn11.frame = CGRectMake(200, 100, 100, 50);
    [btn11 addTarget:self action:@selector(fff) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn11];
    
}

-(void)ff{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        // Do something...
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
//    });
    
//    [self.view makeToastActivity:CSToastPositionCenter];//菊花出现
  
    ToastShowView *toastView = [[ToastShowView alloc]init];
    [toastView showToastWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [toastView hideToastWindow];
    });
    [[UIApplication sharedApplication].keyWindow addSubview:toastView];
    
}
-(void)fff{
    [self.view hideToastActivity];//菊花消失

}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
