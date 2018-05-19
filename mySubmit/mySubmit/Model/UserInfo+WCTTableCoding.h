//
//  UserInfo+WCTTableCoding.h
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "UserInfo.h"
#import <WCDB/WCDB.h>

@interface UserInfo (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(userID)
WCDB_PROPERTY(passWord)


@end
