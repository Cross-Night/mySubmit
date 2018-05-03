//
//  SubmitViewController.m
//  mySubmit
//
//  Created by demo on 2018/5/3.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "SubmitViewController.h"
#import <ReactiveCocoa.h>


@interface SubmitViewController (){
    HTTPServer * httpServer;
}

//fileArray
@property (nonatomic, strong) NSMutableArray *fileArray;
@property (nonatomic, strong) NSString * ipString;

@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFile) name:@"processEpilogueData" object:nil];
    
    // 获取文件存储位置
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"filePath : %@", filePath);
    
    httpServer = [[HTTPServer alloc] init];
    [httpServer setType:@"_http._tcp."];
    // webPath是server搜寻HTML等文件的路径
    NSString *webPath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"webPath : %@", webPath);
    [httpServer setDocumentRoot:webPath];
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    NSError *err;
    
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
    if ([httpServer start:&err]) {
        
        self.ipString = [NSString string];
        
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            self.ipString = @"（您正在4G/3G/2G网络下，暂无法使用）";
            self.wifiLabel.text = @"请连接WIFI";
        }else if (status == AFNetworkReachabilityStatusNotReachable){
            self.ipString = @"您当前无网络";
            self.wifiLabel.text = @"请连接WIFI";
        }else{
            self.ipString = [NSString stringWithFormat:@"http://%@:%d/",[SJXCSMIPHelper deviceIPAdress],[httpServer listeningPort]];
            self.wifiLabel.text = @"已连接WIFI";
        }
        self.ipAddressLabel.text = self.ipString;
        NSLog(@"ipString : %@",self.ipString);
        //  self.showIpLabel.hidden = NO;
        //        NSString *ipString = [NSString stringWithFormat:@"请在网页输入这个地址  http://%@:%hu/", [SJXCSMIPHelper deviceIPAdress], [httpServer listeningPort]];
        // self.showIpLabel.text = ipString;
        //        NSLog(@"ipString : %@", ipString);
        
    }else{
        NSLog(@"%@",err);
    }
    
    @weakify(self);
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        @strongify(self);
        switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                self.ipAddressLabel.text = @"您当前无网络";
                self.wifiLabel.text = @"请连接WIFI";
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                self.ipAddressLabel.text = @"您正在4G/3G/2G网络下，暂无法使用";
                self.wifiLabel.text = @"请连接WIFI";
                break;
            default:
                self.ipAddressLabel.text = self.ipString;
                self.wifiLabel.text = @"已连接WIFI";
                break;
        }
    }];
    

    // Do any additional setup after loading the view.
}

- (void)showFile {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"filePath : %@", filePath);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
