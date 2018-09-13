//
//  GlobalDefineDataBase.h
//  Assistant
//
//  Created by 小毅 on 2018/7/30.
//  Copyright © 2018年 yiheni. All rights reserved.
//

/**
 *Class Name:  全局数据字典
 *Class For What :
 
 *UseWay:
 [[[GlobalDefineDataBase globalDatAappointStatusIntDict] valueForKey:ChangeNullString(urlModel.appointStatus)] integerValue]
 */

#import <Foundation/Foundation.h>

@interface GlobalDefineDataBase : NSObject


#pragma mark - 全局变量or常量
//年份和月份不得大于今天的年月日期
extern NSString * const CheckoutPickedTimeDateOverThisMonthTosat;
//所选日期不得大于今天的日期
extern NSString * const CheckoutPickedTimeDateOverTodayTosat;





#pragma mark - 数据字典
/**
 性别
 */
+(NSDictionary *)globalDataGenderDict;

/**
ABO型
 */
+(NSDictionary *)globalDataBloodTypeAbDict;

/**
 rh血型
 */
+(NSDictionary *)globalDataBloodTypeRhDict;

/**
 预约状态。0-待安排 1-待就诊 2-完成 3-已取消(个人原因) 4-已关闭(爽约) 规则：必填(修改)
 */
+(NSDictionary *)globalDatAappointStatusDict;
/**
 预约状态。0-待安排 1-待就诊 2-完成 3-已取消(个人原因) 4-已关闭(爽约) 规则：必填(修改)
 */
+(NSDictionary *)globalDatAappointStatusIntDict;
/**
医小助订单状态。0-待抢单 1-待沟通 2-待就诊 3-待记录 4-待随访 5-已完成 6-已取消 规则：必填(修改)
 */
+(NSDictionary *)globalDatAassistOrderStatusDict;

/**
执业点服务类型。1-名医 2-手术 3-检验 4-输液 5-治疗 6-医美
 */
+(NSDictionary *)globalDataServiceTypeDict;
/**
 执业点服务类型的标签Icon。1-名医 2-手术 3-检验 4-输液 5-治疗 6-医美
 */
+(NSDictionary *)globalDataServiceTypeIconNameDict;

/**
 支付平台类型，1-微信、2-支付宝、3-银联
 */
+(NSDictionary *)globalDataPaymentPlatformTypeDict;

/**
支付状态。0-未支付;1-已支付;2-已退费;-1-支付失败;-2-退款中。规则：必填(修改)
 */
+(NSDictionary *)globalDataPaymentStatusDict;

/**
支付方式,1-微信公众号;2-微信小程序;3-微信扫码;4-app支付;5-支付宝服务窗支付
 */
+(NSDictionary *)globalDataPaymentWayDict;





/**
 根据Value 查找对应的Key
 
 @param dict 数据字典
 @param value 值
 @return key
 */
+(NSString*)findKeyByValueWithDict:(NSDictionary*)dict withValue:(NSString*)value;


@end
