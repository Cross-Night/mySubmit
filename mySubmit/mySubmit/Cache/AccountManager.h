//
//  AccountManager.h
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface AccountManager : NSObject
@property (nonatomic, strong) UserInfo * info;

+ (AccountManager *)defaultManager;
+ (void)destroy;

- (UserInfo *)getUserInfo;

@end
