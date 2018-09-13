//
//  RYSettingViewController.m
//  CustomTools
//
//  Created by 小毅 on 2018/9/6.
//  Copyright © 2018年 小毅. All rights reserved.
//

#import "RYSettingViewController.h"

@interface RYSettingViewController ()

@end

@implementation RYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      DLog(@" =============  viewDidLoad");
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
    self.view.backgroundColor = [UIColor whiteColor];
    DLog(@" =============  initBaseUI ");

}


//Dog.m文件 实现部分。set方法不做操作
-(void)setAge:(NSInteger)age {
    DLog(@"年龄 ====  %ld",age);
}

//- (NSInteger)age {
//
//
//    return 10;
//}

@end
