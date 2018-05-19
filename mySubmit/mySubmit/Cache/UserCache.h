//
//  UserCache.h
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache.h>
#import "UserInfo.h"
#import <ReactiveCocoa.h>

@interface UserCache : NSObject

+ (instancetype)shareCache;

/**
 查询用户信息
 
 @param uid 用户id
 @return rac
 */
- (RACSignal *)getUserInfoFromCacheWith:(NSString *)uid;


/**
 缓存用户信息
 
 @param userInfo 用户信息
 */
- (void)saveUserInfo:(UserInfo *)userInfo;


/**
 移除用户信息
 
 @param key key
 */
- (void)removeUserInfoWithKey:(NSString *)key;


/**
 移除所有用户信息
 */
- (void)removeAllObject;


@end
