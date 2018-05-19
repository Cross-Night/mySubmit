//
//  SubmitViewController.h
//  mySubmit
//
//  Created by demo on 2018/5/3.
//  Copyright © 2018年 demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MyHTTPConnection.h"
#import "SJXCSMIPHelper.h"
#import <AFNetworkReachabilityManager.h>
#import "UserInfo.h"


@interface SubmitViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wifiLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *fileCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (nonatomic, strong) UserInfo * info;

@end
