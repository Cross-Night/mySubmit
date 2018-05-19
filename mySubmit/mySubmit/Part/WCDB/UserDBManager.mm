//
//  UserDBManager.m
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "UserDBManager.h"
#import "UserInfo+WCTTableCoding.h"

static UserDBManager * instance = nil;
static NSString * const UserTable = @"user";

@interface UserDBManager()
@property (nonatomic, strong) WCTDatabase * dataBase;
@property (nonatomic, strong) WCTTable * table;
@end

@implementation UserDBManager
{
    dispatch_queue_t writeQueue;
}

#pragma mark - Life Cycle
+ (UserDBManager *)defaultManager {
    if (instance) {
        return instance;
    }
    @synchronized (self) {
        if (instance == nil) {
            instance = [[UserDBManager alloc] init];
            [instance creatUserDB];
        }
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        writeQueue = dispatch_queue_create("com.yy.face.YYFace.UserDb", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)creatOrUpdateUser:(UserInfo *)user complete:(void (^)(void))complete {
    BOOL result = NO;
    dispatch_async(writeQueue, ^{
        [_table insertOrReplaceObject:user];
        if (complete) {
            complete();
        }
    });
}


- (void)creatOrUpdateUsers:(NSArray *)users {
    BOOL result = NO;
    if (users.count > 0) {
        dispatch_async(writeQueue, ^{
            [_table insertOrReplaceObjects:users];
        });
    }
}


#pragma mark - Creat UserDB
- (BOOL)creatUserDB {
    [WCTStatistics SetGlobalErrorReport:^(WCTError *error) {
        NSLog(@"创建数据库出错了");
        //[YYLogger info:TWCDB message:@"create WCDB Table failure at Document  %@", error.description];
        //        NSLog(@"[WCDB]%@", error.description);
    }];
    
    NSString *databasePath = [self getDBPath];
    //    if (![CommonFileUtils isFileExists:databasePath]) {
    _dataBase = [[WCTDatabase alloc] initWithPath:databasePath];
    //    }
    
    BOOL isExist = [_dataBase isTableExists:NSStringFromClass(UserInfo.class)];
    if (!isExist) {
        BOOL result = [_dataBase createTableAndIndexesOfName:NSStringFromClass(UserInfo.class)
                                                   withClass:UserInfo.class];
        if (result) {
            _table = [_dataBase getTableOfName:NSStringFromClass(UserInfo.class) withClass:UserInfo.class];
        }
    }else {
        _table = [_dataBase getTableOfName:NSStringFromClass(UserInfo.class) withClass:UserInfo.class];
    }
    return YES;
}


- (NSString *)getDBPath {
    NSString *path = [NSString stringWithFormat:@"Documents/database/%@",@"user"];
    NSString *databasePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    NSString *dbName = [NSString stringWithFormat:@"%@.db",@"user"];
    databasePath = [databasePath stringByAppendingPathComponent:dbName];
    return databasePath;
}

+ (void)destroy {
    instance = nil;
}

#pragma mark - Insert
- (BOOL)insertUser:(UserInfo *)user {
    //    return [_table insertOrReplaceObject:user];
    //    return [_table insertObject:user];
    return [_dataBase insertOrReplaceObject:user into:NSStringFromClass(UserInfo.class)];
}


#pragma mark - Update
- (BOOL)updateUser:(UserInfo *)user {
    return [_table updateRowsOnProperties:UserInfo.AllProperties
                               withObject:user
                                    where:UserInfo.userID == user.userID];
}


#pragma mark - Delete
- (BOOL)deletUser:(UserInfo *)user {
    return [_table deleteObjectsWhere:UserInfo.userID == user.userID];
}

- (BOOL)deletAllUsers {
    return [_table deleteAllObjects];
}

#pragma mark - Select
- (void)getUserWithUserID:(NSString *)userID success:(void (^)(UserInfo *userInfo))success {
    dispatch_async(writeQueue, ^{
        //        [_table insertOrReplaceObject:user];
        UserInfo *info = [_table getOneObjectWhere:UserInfo.userID == userID];
        success(info);
    });
    //    return ;
}

- (UserInfo *)getUserWithUserID:(NSString *)userID {
    return [_table getOneObjectWhere:UserInfo.userID == userID];
}


- (NSArray<UserInfo *> *)getUsersWithUserIDs:(NSArray *)uid {
    
    NSMutableArray *users = [NSMutableArray array];
    for (NSString *userId in uid) {
        UserInfo *userInfo = [self getUserWithUserID:userId];
        [users addObject:userInfo];
    }
    return users;
}

- (NSArray *)getAllUser {
    return [_table getAllObjects];
}


@end
