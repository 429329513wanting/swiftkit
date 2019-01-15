//
//  SendIFAPPDefault.m
//  LaoShan
//
//  Created by sendInfo on 2014-01-09.
//  Copyright (c) 2014年 dongMac. All rights reserved.
//

#import "SendIFAPPDefault.h"

@interface SendIFAPPDefault()
@property (nonatomic,strong)NSUserDefaults *defaults;
@end


@implementation SendIFAPPDefault
@synthesize defaults = _defaults;

+ (SendIFAPPDefault *)shareAppDefault{
    static id _sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [[SendIFAPPDefault alloc] initDefaults];
    });
    return _sharedObj;
}

- (id)initDefaults{
    
    self = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
        [self registerSettings];
    }
    return self;
    
    
}
//程序启动时导入配置文件

- (void)registerSettings{
    
    NSString *settingsPath = [[NSBundle mainBundle] pathForResource:@"SendIFAPPSeting" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
    [self.defaults registerDefaults:dic];
    
    
}
#pragma mark -
- (void)setIsFirstLanuch:(NSString *)isFirst{
    
    [self.defaults setObject:isFirst forKey:IS_FIRSTLANUCH];
    [self.defaults synchronize];

}
- (NSString *)isFirstLanuch{
    
    return [self.defaults stringForKey:IS_FIRSTLANUCH];

}

- (void)setIsSelectLanguage:(NSString *)isSelect{

    [self.defaults setObject:isSelect forKey:IS_SELECT_LANGUAGE];
    [self.defaults synchronize];
    
}
- (NSString *)isSelectLanguage{

    return [self.defaults stringForKey:IS_SELECT_LANGUAGE];

}

#pragma mark -
- (void)setSyncDate:(NSString *)date{
    [self.defaults setObject:date forKey:SYNC_DATE];
    [self.defaults synchronize];
}
- (NSString *)syncDate{
    
    return [self.defaults stringForKey:SYNC_DATE];

}

- (void)setMobile:(NSString *)mobile{
    
    [self.defaults setObject:mobile forKey:MOBILE];
    [self.defaults synchronize];
}
- (NSString *)mobile{
    
    return [self.defaults stringForKey:MOBILE];

}

- (void)setUserPhoto:(NSString *)photo{
    
    
    [self.defaults setObject:photo forKey:USER_PHOTO];
    [self.defaults synchronize];
}
- (NSString *)userPhoto{
    
    return [self.defaults stringForKey:USER_PHOTO];

}

- (void)setCurlat:(NSString *)lat{
    
    [self.defaults setObject:lat forKey:CURRENT_LAT];
    [self.defaults synchronize];
}
- (NSString *)curlat{
    
    return [self.defaults stringForKey:CURRENT_LAT];

}

- (void)setCurlongt:(NSString *)longt{
    
    [self.defaults setObject:longt forKey:CURRENT_LONGT];
    [self.defaults synchronize];
}
- (NSString *)curlongt{
    
    return [self.defaults stringForKey:CURRENT_LONGT];

}

#pragma mark -
- (void)setCurrentUserID:(NSString *)userNum{
[self.defaults setObject:userNum forKey:CURRENT_USER_ID];
    [self.defaults synchronize];

}
- (NSString *)currentUserID{
    
    return [self.defaults stringForKey:CURRENT_USER_ID];

}
- (void)setCurrentShopID:(NSString *)sid{
    
    [self.defaults setObject:sid forKey:SHOPID];
    [self.defaults synchronize];
}
- (NSString *)currentShopID{
    
    return [self.defaults stringForKey:SHOPID];
}
#pragma mark -
//登录状态
- (void)setLoginState:(NSString *)state{
    
    [self.defaults setObject:state forKey:LOGIN_STATE];
    [self.defaults synchronize];

}
- (NSString *)loginState{
    return [self.defaults stringForKey:LOGIN_STATE];
}
#pragma mark -
- (void)setLoginName:(NSString *)name{
    
    [self.defaults setObject:name forKey:LOGIN_NAME];
    [self.defaults synchronize];

}
- (NSString *)loginName{
    
    return [self.defaults stringForKey:LOGIN_NAME];

}
- (void)setIsForceRightToLeft:(NSString *)direction
{

    [self.defaults setObject:direction forKey:IS_FROM_RIGHT_LEFT];
    [self.defaults synchronize];

}
- (void)setToken:(NSString *)token{
    
    [self.defaults setObject:token forKey:TOKEN];
    [self.defaults synchronize];
}
- (NSString *)token{
    
    return [self.defaults stringForKey:TOKEN];
    
}

- (void)setUserRole:(NSString *)role{

    [self.defaults setObject:role forKey:USER_ROLE];
    [self.defaults synchronize];
    
}
- (NSString *)userRole{

    return [self.defaults stringForKey:USER_ROLE];
}

- (NSString *)isForceRightToLeft{

    return [self.defaults stringForKey:IS_FROM_RIGHT_LEFT];
}

- (void)setAccountType:(NSString *)type{

    [self.defaults setObject:type forKey:Account_TYpe];
    [self.defaults synchronize];
}
- (NSString *)accountType{

    return [self.defaults stringForKey:Account_TYpe];

}
- (void)setPasspoartNO:(NSString *)number{

    [self.defaults setObject:number forKey:PASSPOART_NO];
    [self.defaults synchronize];
}
- (NSString *)passpoartNO{

    return [self.defaults stringForKey:PASSPOART_NO];

}
- (void)setClickUnityId:(NSString *)ID{
    
    [self.defaults setObject:ID forKey:OTHERUNITYID];
    [self.defaults synchronize];
}
- (NSString *)clickUnityId{
    
    return [self.defaults stringForKey:OTHERUNITYID];

}
- (void)setNeckName:(NSString *)name{
    
    [self.defaults setObject:name forKey:NECK_NAME];
    [self.defaults synchronize];
    
}
- (NSString *)NeckName{
    return [self.defaults stringForKey:NECK_NAME];
    
}

- (void)setAreaID:(NSString *)areaid{
    
    [self.defaults setObject:areaid forKey:AREAID];
    [self.defaults synchronize];
}
- (NSString *)areaID{
    
    return [self.defaults stringForKey:AREAID];

}

- (void)setAreaName:(NSString *)name{
    
    [self.defaults setObject:name forKey:AREA_NAME];
    [self.defaults synchronize];
}

- (NSString *)areaName{
    
    return [self.defaults stringForKey:AREA_NAME];
}
- (void)setIsAdmin:(NSString *)admin{
    
    [self.defaults setObject:admin forKey:ISADMIN];
    [self.defaults synchronize];
}
- (NSString *)isAdmin{
    
    return [self.defaults stringForKey:ISADMIN];
}

- (void)setDefaultAddr:(NSDictionary *)addr{

    [self.defaults setObject:addr forKey:DEFAULT_ADDR];
    [self.defaults synchronize];
}
- (NSDictionary *)defaultAddr{

    return [self.defaults objectForKey:DEFAULT_ADDR];

}

- (void)clear{

    [[SendIFAPPDefault shareAppDefault] setLoginState:@"0"];
    [[SendIFAPPDefault shareAppDefault] setToken:@""];
    [SendIFAPPDefault shareAppDefault].defaultAddr = nil;
    
}

@end
