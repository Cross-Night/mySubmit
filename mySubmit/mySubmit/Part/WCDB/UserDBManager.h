//
//  UserDBManager.h
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserDBManager : NSObject

#pragma mark - Life Cycle
+ (UserDBManager *)defaultManager;
+ (void)destroy;

#pragma mark - CreatOrUpdate

- (void)creatOrUpdateUser:(UserInfo *)user complete:(void (^)(void))complete;
- (void)creatOrUpdateUsers:(NSArray *)users;

#pragma mark - Insert
- (BOOL)insertUser:(UserInfo *)user;

#pragma mark - Update
- (BOOL)updateUser:(UserInfo *)user;

#pragma mark - Delete
- (BOOL)deletUser:(UserInfo *)user;
- (BOOL)deletAllUsers;

#pragma mark - Select
- (void)getUserWithUserID:(NSString *)UserID success:(void (^)(UserInfo *userInfo))success;
- (UserInfo *)getUserWithUserID:(NSString *)UserID;
- (NSArray<UserInfo *> *)getUsersWithUserIDs:(NSArray *)userIDs;
- (NSArray *)getAllUsers;


@end
