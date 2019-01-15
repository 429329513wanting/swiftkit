//
//  SPUtil.h
//  BaseSwift
//
//  Created by ghwang on 2019/1/9.
//  Copyright © 2019 ghwang. All rights reserved.
//

#import "UDUserDefaultsModel.h"


@interface SPUtil : UDUserDefaultsModel
    
@property(nonatomic,strong) NSString *loginName;
    
@property(nonatomic,strong) NSString *userId;
    
@property(nonatomic,assign) int loginStatus;

@end

