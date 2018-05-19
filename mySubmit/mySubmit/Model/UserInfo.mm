//
//  UserInfo.mm
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "UserInfo+WCTTableCoding.h"
#import "UserInfo.h"
#import <WCDB/WCDB.h>

//@interface UserInfo()<NSCoding>
//@end

@implementation UserInfo

WCDB_IMPLEMENTATION(UserInfo)

WCDB_SYNTHESIZE(UserInfo, userID)
WCDB_SYNTHESIZE(UserInfo, passWord)

WCDB_PRIMARY(UserInfo, userID)

WCDB_INDEX(UserInfo, "_index", userID)


//WCDB_UNIQUE(UserInfo, <#property3#>)
//WCDB_NOT_NULL(UserInfo, <#property4#>)
//
@end
