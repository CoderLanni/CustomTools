//
//  GVUserDefaults+Properties.h
//  DUGeneral
//
//  Created by 小毅 on 2018/5/31.
//  Copyright © 2018年 小毅. All rights reserved.
//

#import <GVUserDefaults/GVUserDefaults.h>

@interface GVUserDefaults (Properties)


//登录的用户信息
@property (nonatomic, weak) NSString *userName;
@property (nonatomic, weak) NSString *password;
@property (nonatomic, weak) NSString *userId;
@property (nonatomic, weak) NSString *token;
@property (nonatomic, weak) NSString *referenPhone;
@property (nonatomic, weak) NSString *nickName;
@property (nonatomic, weak) NSString *referenName;
@property (nonatomic, weak) NSString *referenId;
@property (nonatomic, assign) NSInteger isReferen;
//@property (nonatomic, assign) NSInteger authStatus;
@property (nonatomic, weak) NSString *phone;
/**
 输入的手机号
 */
@property (nonatomic, weak) NSString *inputPhone;
@property (nonatomic, weak) NSString *headImgUrl;
@property (nonatomic, assign) NSInteger authType;
@property (nonatomic, assign) NSInteger isNewUser;
@property(nonatomic ,strong) NSString *nonce;


@property(nonatomic ,strong) NSString *userIdMD5;




@property(nonatomic ,strong) NSString *appSecret;

//@property(nonatomic ,strong) NSMutableArray *historySearchArr;

#pragma mark - 医小助
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger serviceType;
@property (nonatomic, assign) NSInteger isNurse;
/**
 认证状态：0-通过认证，1-认证中，2-未通过认证，3-未认证（默认）
 */
@property(nonatomic ,assign) NSInteger authStatus;
@property(nonatomic ,strong) NSString *idCard;

/**
 服务点ID
 */
@property(nonatomic ,strong) NSString *instOfficeId;
/**
 服务点名称
 */
@property(nonatomic ,strong) NSString *instOfficeName;

/**
 医小助服务的执业点
 */
@property(nonatomic ,strong) NSData *assistantOfficesData;

@end
