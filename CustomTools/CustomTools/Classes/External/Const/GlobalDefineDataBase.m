//
//  GlobalDefineDataBase.m
//  Assistant
//
//  Created by 小毅 on 2018/7/30.
//  Copyright © 2018年 yiheni. All rights reserved.
//

#import "GlobalDefineDataBase.h"

@implementation GlobalDefineDataBase


#pragma mark - 全局变量or常量

//年份和月份不得大于今天的年月日期
 NSString * const CheckoutPickedTimeDateOverThisMonthTosat = @"年份和月份不得大于今天的年月日期";
//年份和月份不得大于今天的年月日期
NSString * const CheckoutPickedTimeDateOverTodayTosat = @"所选日期不得大于今天的日期";



#pragma mark - 数据字典

+(NSDictionary *)globalDataGenderDict{
    NSDictionary *dict = @{@"0":@"保密",@"1":@"男",@"2":@"女"};
    return dict;
}


+(NSDictionary *)globalDataBloodTypeAbDict{
    NSDictionary *dict = @{@"1":@"A型",@"2":@"B型",@"3":@"AB型",@"4":@"O型",@"5":@"未知"};
    return dict;
}


+(NSDictionary *)globalDataBloodTypeRhDict{
    NSDictionary *dict = @{@"1":@"Rh阴",@"2":@"Rh阳",@"3":@"未知"};
    return dict;
}


/**
 预约状态。0-待安排 1-待就诊 2-完成 3-已取消(个人原因) 4-已关闭(爽约) 规则：必填(修改)
 */
+(NSDictionary *)globalDatAappointStatusDict{
    NSDictionary *dict = @{@"0":@"待安排",@"1":@"待就诊",@"2":@"完成",@"3":@"已取消(个人原因)",@"4":@"已关闭(爽约)"};
    return dict;
}
/**
 预约状态。0-待安排 1-待就诊 2-完成 3-已取消(个人原因) 4-已关闭(爽约) 规则：必填(修改)
 */
+(NSDictionary *)globalDatAappointStatusIntDict{
    NSDictionary *dict = @{@"待安排":@"0",@"待就诊":@"1",@"完成":@"2",@"已取消":@"3",@"已关闭(爽约)":@"4"};
    return dict;
}

/**
 医小助订单状态。0-待抢单 1-待沟通 2-待就诊 3-待记录 4-待随访 5-已完成 6-已取消 规则：必填(修改)
 */
+(NSDictionary *)globalDatAassistOrderStatusDict{
    NSDictionary *dict = @{@"0":@"待抢单",@"1":@"待沟通",@"2":@"待就诊",@"3":@"待记录",@"4":@"待随访",@"5":@"已完成",@"5":@"已取消"};
    return dict;
}


/**
 执业点服务类型。1-名医 2-手术 3-检验 4-输液 5-治疗 6-医美
 */
+(NSDictionary *)globalDataServiceTypeDict{
    NSDictionary *dict = @{@"1":@"名医",@"2":@"手术",@"3":@"检验",@"4":@"输液",@"5":@"治疗",@"6":@"医美"};
    return dict;
}
/**
 执业点服务类型的标签Icon。1-名医 2-手术 3-检验 4-输液 5-治疗 6-医美
 */
+(NSDictionary *)globalDataServiceTypeIconNameDict{
    NSDictionary *dict = @{@"1":@"famous_doctors_tag_icon",@"2":@"operation_tag_icon",@"3":@"checking_tag_icon",@"4":@"transfornt_tag_icon",@"5":@"zhiliao_tag_icon",@"6":@"yimei_tag_icon"};
    return dict;
}


/**
 支付平台类型，1-微信、2-支付宝、3-银联
 */
+(NSDictionary *)globalDataPaymentPlatformTypeDict{
    NSDictionary *dict = @{@"1":@"微信",@"2":@"支付宝",@"3":@"银联"};
    return dict;
}


/**
 支付状态。0-未支付;1-已支付;2-已退费;-1-支付失败;-2-退款中。规则：必填(修改)
 */
+(NSDictionary *)globalDataPaymentStatusDict{
    NSDictionary *dict = @{@"0":@"未支付",@"1":@"已支付",@"2":@"已退费",@"-1":@"支付失败",@"-2":@"退款中"};
    return dict;
}


/**
 支付方式,1-微信公众号;2-微信小程序;3-微信扫码;4-app支付;5-支付宝服务窗支付
 */
+(NSDictionary *)globalDataPaymentWayDict{
    NSDictionary *dict = @{@"1":@"微信公众号",@"2":@"微信小程序",@"3":@"微信扫码",@"4":@"app支付",@"5":@"支付宝服务窗支付"};
    return dict;
}






/**
 根据Value 查找对应的Key

 @param dict 数据字典
 @param value 值
 @return key
 */
+(NSString*)findKeyByValueWithDict:(NSDictionary*)dict withValue:(NSString*)value{
    __block NSString *objectEightId;
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSLog(@"key = %@ and obj = %@", key, obj);
        if ([obj isEqualToString:value]) {
            objectEightId = key;
        }
    }];
    return objectEightId;
}


@end
