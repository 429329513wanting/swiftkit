//
//  SendIFAPPDefault.h
//  LaoShan
//
//  Created by sendInfo on 2014-01-09.
//  Copyright (c) 2014年 dongMac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_FIRSTLANUCH @"is_firstlanuch"
#define SYNC_DATE @"syncDate"
#define CURRENT_USER_ID @"current_user_id"
#define LOGIN_STATE @"login_state"
#define LOGIN_NAME @"logname"
#define ACCOUNTID  @"accountID"
#define NECK_NAME  @"neckname"

#define IS_FROM_RIGHT_LEFT @"is_from_right_left"
#define IS_SELECT_LANGUAGE @"is_select_language"
#define Account_TYpe @"account_type"
#define TOKEN @"token"
#define USER_ROLE @"user_role"
#define PASSPOART_NO @"passportNo"
#define DEFAULT_ADDR @"def_addr"
#define USER_PHOTO @"user_photo"
#define MOBILE @"mobile"
#define AREAID @"areaid"
#define AREA_NAME @"area_name"
#define CURRENT_LAT @"current_lat"
#define CURRENT_LONGT @"current_longt"
#define SHOPID @"shop_id"
#define ISADMIN @"is_admin"
#define OTHERUNITYID @"otherunityid"


@interface SendIFAPPDefault : NSObject

@property(nonatomic,strong) NSArray *areas;


+ (SendIFAPPDefault *)shareAppDefault;

//是否是第一次启动
- (void)setIsFirstLanuch:(NSString *)isFirst;
- (NSString *)isFirstLanuch;

- (void)setIsSelectLanguage:(NSString *)isSelect;
- (NSString *)isSelectLanguage;
//同步时间
- (void)setSyncDate:(NSString *)date;
- (NSString *)syncDate;
//当前用户id
- (void)setCurrentUserID:(NSString *)userNum;
- (NSString *)currentUserID;

//当前店铺id
- (void)setCurrentShopID:(NSString *)sid;
- (NSString *)currentShopID;
//登录状态
- (void)setLoginState:(NSString *)state;

- (NSString *)loginState;
//登录名//手机号什么的
- (void)setLoginName:(NSString *)name;
- (NSString *)loginName;
//

- (void)setIsForceRightToLeft:(NSString *)direction;
- (NSString *)isForceRightToLeft;

//当前用户token
- (void)setToken:(NSString *)token;
- (NSString *)token;

- (void)setUserRole:(NSString *)role;
- (NSString *)userRole;

- (void)setAccountType:(NSString *)type;
- (NSString *)accountType;

- (void)setClickUnityId:(NSString *)ID;
- (NSString *)clickUnityId;

- (void)setPasspoartNO:(NSString *)number;
- (NSString *)passpoartNO;

- (void)setMobile:(NSString *)mobile;
- (NSString *)mobile;

- (void)setUserPhoto:(NSString *)photo;
- (NSString *)userPhoto;

- (void)setCurlat:(NSString *)lat;
- (NSString *)curlat;

- (void)setCurlongt:(NSString *)longt;
- (NSString *)curlongt;

//用户名字

- (void)setNeckName:(NSString *)name;
- (NSString *)NeckName;

- (void)setAreaID:(NSString *)areaid;
- (NSString *)areaID;

- (void)setAreaName:(NSString *)name;
- (NSString *)areaName;

- (void)setIsAdmin:(NSString *)admin;
- (NSString *)isAdmin;

- (void)setDefaultAddr:(NSDictionary *)addr;
- (NSDictionary *)defaultAddr;

//-(void)setAccountID:(NSString *)accountID;
//-(NSString *)accountID;

- (void)clear;
@end
