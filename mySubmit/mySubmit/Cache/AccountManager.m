//
//  AccountManager.m
//  mySubmit
//
//  Created by demo on 2018/5/18.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "AccountManager.h"

static AccountManager * instance = nil;

@implementation AccountManager

+ (AccountManager *)defaultManager{
    if (instance) {
        return instance;
    }
    @synchronized (self) {
        if (instance == nil) {
            instance = [[AccountManager alloc] init];
        }
    }
    return instance;
}

+ (void)destroy{
    instance = nil;
}

- (UserInfo *)getUserInfo{
    return self.info;
}

@end
