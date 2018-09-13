//
//  RYMineViewController.m
//  CustomTools
//
//  Created by 小毅 on 2018/8/24.
//  Copyright © 2018年 小毅. All rights reserved.
//

#import "RYMineViewController.h"
#import "RYSettingViewController.h"

@interface RYMineViewController ()

@end

@implementation RYMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initBaseUIAndBaseData];
    
    
    
    
}


#pragma mark- initBaseUI & initBaseData
-(void)initBaseUIAndBaseData{
    [self initBaseData];
    [self initBaseUI];
    
}
-(void)initBaseData{
    
    
}
-(void)initBaseUI{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn addTarget:self action:@selector(clickedNextBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
 
    
}

-(void)clickedNextBtnHandle{
    RYSettingViewController *setVC = [RYSettingViewController new];
    setVC.nameStr  = @"lanni";
    setVC.age = 20;
    [self.navigationController pushViewController:setVC animated:YES];
}

@end
